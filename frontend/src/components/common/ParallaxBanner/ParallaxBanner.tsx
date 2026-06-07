import React, { useEffect, useRef, useState } from 'react';

interface ParallaxBannerProps {
  layer1Src: string; // Closest foreground overlay (leaves, grass, details)
  layer2Src: string; // Mid-foreground (bus & road)
  layer3Src: string; // Mid-background (bridge & fields)
  layer4Src: string; // Furthest background (sky & mountains)
  altText: string;
}

export const ParallaxBanner: React.FC<ParallaxBannerProps> = ({
  layer1Src,
  layer2Src,
  layer3Src,
  layer4Src,
  altText,
}) => {
  const containerRef = useRef<HTMLDivElement>(null);
  const canvasRef = useRef<HTMLCanvasElement>(null);
  const [hasWebGL, setHasWebGL] = useState(true);
  const [isLoaded, setIsLoaded] = useState(false);

  useEffect(() => {
    const canvas = canvasRef.current;
    const container = containerRef.current;
    if (!canvas || !container) return;

    let isMounted = true;

    // 1. Get WebGL context
    const gl = canvas.getContext('webgl') || canvas.getContext('experimental-webgl') as WebGLRenderingContext | null;
    if (!gl) {
      console.warn('WebGL not supported, falling back to static image');
      setHasWebGL(false);
      return;
    }

    // 2. Vertex Shader (Maps a standard 2D plane quad covering the viewport)
    const vsSource = `
      attribute vec2 aPosition;
      varying vec2 vUv;
      void main() {
        vUv = aPosition * 0.5 + 0.5;
        // Invert Y to match HTML texture coordinates
        vUv.y = 1.0 - vUv.y;
        gl_Position = vec4(aPosition, 0.0, 1.0);
      }
    `;

    // 3. Fragment Shader: Composites 4 layers from back-to-front with custom zoom and offset weights
    const fsSource = `
      precision mediump float;
      varying vec2 vUv;
      
      uniform sampler2D uLayer1; // Closest
      uniform sampler2D uLayer2; // Bus/Road
      uniform sampler2D uLayer3; // Bridge/Fields
      uniform sampler2D uLayer4; // Sky/Mountains (furthest)
      
      uniform vec2 uOffset;      // Current camera offset vector
      uniform vec2 uScale;       // Aspect ratio scale for cover effect

      void main() {
        // Apply aspect ratio scaling (object-fit: cover logic)
        vec2 aspectUv = (vUv - 0.5) * uScale + 0.5;

        // --- LAYER 1: FOREGROUND OVERLAY ---
        // Exaggerated displacement X=0.095, Y=0.115. Safe Zoom = 1.25
        vec2 uv1 = (aspectUv - 0.5) * (1.0 / 1.25) + 0.5;
        uv1 -= uOffset * vec2(0.095, 0.115);
        uv1 = clamp(uv1, 0.0, 1.0);
        vec4 col1 = texture2D(uLayer1, uv1);

        // --- LAYER 2: BUS & ROAD ---
        // Exaggerated displacement X=0.038, Y=0.046. Safe Zoom = 1.11
        vec2 uv2 = (aspectUv - 0.5) * (1.0 / 1.11) + 0.5;
        uv2 -= uOffset * vec2(0.038, 0.046);
        uv2 = clamp(uv2, 0.0, 1.0);
        vec4 col2 = texture2D(uLayer2, uv2);

        // --- LAYER 3: BRIDGE & FIELDS ---
        // Exaggerated displacement X=0.017, Y=0.021. Safe Zoom = 1.06
        vec2 uv3 = (aspectUv - 0.5) * (1.0 / 1.06) + 0.5;
        uv3 -= uOffset * vec2(0.017, 0.021);
        uv3 = clamp(uv3, 0.0, 1.0);
        vec4 col3 = texture2D(uLayer3, uv3);

        // --- LAYER 4: SKY & MOUNTAINS (BACKGROUND) ---
        // Minimized displacement X=0.005, Y=0.006. Safe Zoom = 1.02
        vec2 uv4 = (aspectUv - 0.5) * (1.0 / 1.02) + 0.5;
        uv4 -= uOffset * vec2(0.005, 0.006);
        uv4 = clamp(uv4, 0.0, 1.0);
        vec4 col4 = texture2D(uLayer4, uv4);

        // Hardware premultiplied alpha blending:
        // C_out = C_fg + C_bg * (1.0 - A_fg)
        // Mathematically eliminates any white/dark border fringes and edge noise under bilinear filtering.
        vec3 blend3_4 = col4.rgb * (1.0 - col3.a) + col3.rgb;
        vec3 blend2_3 = blend3_4 * (1.0 - col2.a) + col2.rgb;
        vec3 finalColor = blend2_3 * (1.0 - col1.a) + col1.rgb;

        gl_FragColor = vec4(finalColor, 1.0);
      }
    `;

    // Helper to compile a shader
    const compileShader = (source: string, type: number): WebGLShader | null => {
      const shader = gl.createShader(type);
      if (!shader) return null;
      gl.shaderSource(shader, source);
      gl.compileShader(shader);
      if (!gl.getShaderParameter(shader, gl.COMPILE_STATUS)) {
        console.error('Shader compilation error:', gl.getShaderInfoLog(shader));
        gl.deleteShader(shader);
        return null;
      }
      return shader;
    };

    const vs = compileShader(vsSource, gl.VERTEX_SHADER);
    const fs = compileShader(fsSource, gl.FRAGMENT_SHADER);
    if (!vs || !fs) {
      setHasWebGL(false);
      return;
    }

    // 4. Create WebGL Program
    const program = gl.createProgram();
    if (!program) {
      setHasWebGL(false);
      return;
    }
    gl.attachShader(program, vs);
    gl.attachShader(program, fs);
    gl.linkProgram(program);

    if (!gl.getProgramParameter(program, gl.LINK_STATUS)) {
      console.error('Program linking error:', gl.getProgramInfoLog(program));
      setHasWebGL(false);
      return;
    }

    gl.useProgram(program);

    // 5. Plane Geometry (2 triangles making a full screen quad)
    const vertices = new Float32Array([
      -1, -1,
      1, -1,
      -1, 1,
      -1, 1,
      1, -1,
      1, 1,
    ]);

    const buffer = gl.createBuffer();
    gl.bindBuffer(gl.ARRAY_BUFFER, buffer);
    gl.bufferData(gl.ARRAY_BUFFER, vertices, gl.STATIC_DRAW);

    const aPosition = gl.getAttribLocation(program, 'aPosition');
    gl.enableVertexAttribArray(aPosition);
    gl.vertexAttribPointer(aPosition, 2, gl.FLOAT, false, 0, 0);

    // Get Uniform locations
    const uOffsetLoc = gl.getUniformLocation(program, 'uOffset');
    const uScaleLoc = gl.getUniformLocation(program, 'uScale');
    const uLayer1Loc = gl.getUniformLocation(program, 'uLayer1');
    const uLayer2Loc = gl.getUniformLocation(program, 'uLayer2');
    const uLayer3Loc = gl.getUniformLocation(program, 'uLayer3');
    const uLayer4Loc = gl.getUniformLocation(program, 'uLayer4');

    // 6. Texture Loading helper
    let texturesLoaded = 0;
    const initTexture = (
      imageElement: HTMLImageElement,
      textureUnit: number,
      uniformLoc: WebGLUniformLocation | null
    ) => {
      const texture = gl.createTexture();
      gl.activeTexture(gl.TEXTURE0 + textureUnit);
      gl.bindTexture(gl.TEXTURE_2D, texture);

      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_S, gl.CLAMP_TO_EDGE);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_WRAP_T, gl.CLAMP_TO_EDGE);

      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
      gl.texParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);

      // Instruct WebGL to premultiply alpha when uploading textures to the GPU.
      // This mathematically resolves all edge-bleeding, alpha halos, and glittering noise at cut-out boundaries.
      gl.pixelStorei(gl.UNPACK_PREMULTIPLY_ALPHA_WEBGL, true);

      gl.texImage2D(gl.TEXTURE_2D, 0, gl.RGBA, gl.RGBA, gl.UNSIGNED_BYTE, imageElement);
      gl.uniform1i(uniformLoc, textureUnit);

      texturesLoaded++;
    };

    const img1 = new Image();
    const img2 = new Image();
    const img3 = new Image();
    const img4 = new Image();

    const checkStartLoop = () => {
      if (!isMounted) return;
      if (texturesLoaded === 4) {
        resizeCanvas(); // Trigger canvas size and aspect ratio update with loaded dimensions
        startLoop();
        // Trigger a series of delayed fit corrections to catch scrollbar shifts or layout adjustments
        setTimeout(() => {
          if (isMounted) resizeCanvas();
        }, 50);
        setTimeout(() => {
          if (isMounted) resizeCanvas();
        }, 300);
      }
    };

    img1.onload = () => {
      if (!isMounted) return;
      initTexture(img1, 0, uLayer1Loc);
      checkStartLoop();
    };
    img2.onload = () => {
      if (!isMounted) return;
      initTexture(img2, 1, uLayer2Loc);
      checkStartLoop();
    };
    img3.onload = () => {
      if (!isMounted) return;
      initTexture(img3, 2, uLayer3Loc);
      checkStartLoop();
    };
    img4.onload = () => {
      if (!isMounted) return;
      initTexture(img4, 3, uLayer4Loc);
      checkStartLoop();
    };

    img1.src = layer1Src;
    img2.src = layer2Src;
    img3.src = layer3Src;
    img4.src = layer4Src;

    // Handle container resizing to preserve widescreen dimensions without stretching
    const resizeCanvas = () => {
      if (!canvas || !container || !isMounted) return;

      const width = container.clientWidth;
      const height = container.clientHeight;
      const dpr = window.devicePixelRatio || 1;

      // Render at high DPI Retina resolution
      canvas.width = width * dpr;
      canvas.height = height * dpr;
      gl.viewport(0, 0, width * dpr, height * dpr);

      // Object-fit: cover calculation
      const imgW = img4.naturalWidth || 3608;
      const imgH = img4.naturalHeight || 1184;
      const imgAspect = imgW / imgH;
      const canvasAspect = width / height;

      let scaleX = 1.0;
      let scaleY = 1.0;

      if (canvasAspect > imgAspect) {
        scaleY = imgAspect / canvasAspect;
      } else {
        scaleX = canvasAspect / imgAspect;
      }

      gl.useProgram(program);
      gl.uniform2f(uScaleLoc, scaleX, scaleY);
    };

    const handleResize = () => {
      if (isMounted) resizeCanvas();
    };
    window.addEventListener('resize', handleResize);

    // 7. Setup IntersectionObserver to pause rendering when off-screen (GPU optimization)
    let isVisible = true;
    const observer = new IntersectionObserver(
      ([entry]) => {
        if (isMounted) {
          isVisible = entry.isIntersecting;
        }
      },
      { threshold: 0.05 }
    );
    observer.observe(container);

    // 8. Dynamic camera animation loop (Pure, uninterrupted Lissajous orbital sway)
    let animationFrameId: number;
    let lastTime = performance.now();
    let accumulatedTime = 0;
    let firstFrameRendered = false;
    const startLoop = () => {
      const render = () => {
        if (!isMounted) return; // Exit loop completely if unmounted
        const now = performance.now();
        if (!isVisible) {
          lastTime = now; // Prevent delta spike on resume
          animationFrameId = requestAnimationFrame(render);
          return;
        }

        let dt = (now - lastTime) * 0.0012; // Delta time scaled
        lastTime = now;

        // Cap dt to prevent any massive spikes (e.g. if the tab was suspended/throttled)
        if (dt > 0.1) {
          dt = 0.1;
        }

        // Only accumulate time if the page is visible
        if (document.visibilityState === 'visible') {
          accumulatedTime += dt;
        }

        // Premium constant Lissajous amplitudes (X: 0.45, Y: 0.65)
        // This coordinates all layers into a organic, infinite orbital camera sweep.
        const currentX = Math.sin(accumulatedTime * 0.55) * 0.45;
        const currentY = Math.cos(accumulatedTime * 0.45) * 0.65;

        gl.uniform2f(uOffsetLoc, currentX, currentY);

        gl.clearColor(0, 0, 0, 0);
        gl.clear(gl.COLOR_BUFFER_BIT);
        gl.drawArrays(gl.TRIANGLES, 0, 6);

        if (!firstFrameRendered) {
          firstFrameRendered = true;
          setIsLoaded(true);
        }

        animationFrameId = requestAnimationFrame(render);
      };
      animationFrameId = requestAnimationFrame(render);
    };

    const handleVisibilityChange = () => {
      if (!isMounted) return;
      if (document.visibilityState === 'visible') {
        // Reset lastTime on tab focus to prevent a large delta spike
        lastTime = performance.now();
      }
    };

    document.addEventListener('visibilitychange', handleVisibilityChange);

    // Cleanup resources on unmount
    return () => {
      isMounted = false;
      window.removeEventListener('resize', handleResize);
      document.removeEventListener('visibilitychange', handleVisibilityChange);
      cancelAnimationFrame(animationFrameId);
      observer.disconnect();
      gl.deleteBuffer(buffer);
      gl.deleteProgram(program);
      gl.deleteShader(vs);
      gl.deleteShader(fs);
    };
  }, [layer1Src, layer2Src, layer3Src, layer4Src]);

  if (!hasWebGL) {
    return <img src={layer4Src} alt={altText} className="hero-banner-image" />;
  }

  return (
    <div
      ref={containerRef}
      className="hero-banner-parallax-container"
      style={{ position: 'relative', width: '100%', overflow: 'hidden' }}
    >
      {/* 
        This transparent image tag acts as a 'layout placeholder'.
        It stretches naturally to 100% width and calculates its own height automatically 
        based on the original image aspect ratio. 
      */}
      <img
        src={layer4Src}
        alt={altText}
        className="hero-banner-image"
        style={{
          width: '100%',
          height: 'auto',
          display: 'block',
          opacity: 0,
          pointerEvents: 'none'
        }}
      />

      {/* 
        The WebGL canvas overlays absolutely on top of the transparent image space, 
        matching its dimensions pixel-for-pixel with perfect quality. 
      */}
      <canvas
        ref={canvasRef}
        className={`hero-banner-parallax-canvas ${isLoaded ? 'loaded' : ''}`}
        style={{
          position: 'absolute',
          top: 0,
          left: 0,
          width: '100%',
          height: '100%',
          display: 'block'
        }}
      />
    </div>
  );
};

export default ParallaxBanner;
