// OOP Approach using prototypical inheritance, wrapped in a namespace object as required.

export interface IBaseTicket {
  route: string;
  price: number;
  getSummary(): string;
}

export interface IBusTicket extends IBaseTicket {
  seatNumber: string;
  getDetailedSummary(): string;
}

// BaseTicket Constructor
export interface BaseTicketConstructor {
  new (route: string, price: number): IBaseTicket;
  prototype: IBaseTicket;
}

export const BaseTicket = function (this: IBaseTicket, route: string, price: number) {
  this.route = route;
  this.price = price;
} as unknown as BaseTicketConstructor;

BaseTicket.prototype.getSummary = function (this: IBaseTicket) {
  return `Ticket for ${this.route} costs ${this.price} CZK.`;
};

// BusTicket Constructor
export interface BusTicketConstructor {
  new (route: string, price: number, seatNumber: string): IBusTicket;
  prototype: IBusTicket;
}

export const BusTicket = function (
  this: IBusTicket,
  route: string,
  price: number,
  seatNumber: string
) {
  // Call base constructor
  // eslint-disable-next-line @typescript-eslint/no-explicit-any
  (BaseTicket as any).call(this, route, price);
  this.seatNumber = seatNumber;
} as unknown as BusTicketConstructor;

// Set up prototypical inheritance using Object.create
BusTicket.prototype = Object.create(BaseTicket.prototype);

// Restore constructor reference
BusTicket.prototype.constructor = BusTicket;

// Add subclass method
BusTicket.prototype.getDetailedSummary = function (this: IBusTicket) {
  return `${this.getSummary()} Assigned Seat: ${this.seatNumber}.`;
};

// Namespace object
export const OmnibusOOP = {
  BaseTicket,
  BusTicket
};
