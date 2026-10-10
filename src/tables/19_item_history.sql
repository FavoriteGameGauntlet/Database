CREATE TABLE IF NOT EXISTS users.ItemHistory (
  Id         INTEGER PRIMARY KEY,
  PartyId    INTEGER NOT NULL REFERENCES common.Parties (Id),
  ItemId     INTEGER NOT NULL,
  UserItemId INTEGER NOT NULL,
  UsesLeft   INTEGER CHECK ( UsesLeft IS NULL OR UsesLeft >= 0 ),

  UNIQUE (Id, PartyId),
  FOREIGN KEY (Id, PartyId) REFERENCES users.HistoryEvents (Id, PartyId),
  FOREIGN KEY (ItemId, PartyId) REFERENCES party.Items (Id, PartyId)
);
