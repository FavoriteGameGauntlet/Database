INSERT INTO defaults.SystemParameters (Code, DefaultValue, Name, Description)
VALUES ('MinimumNumberOfWishlistGames',        '3',       'MinimumNumberOfWishlistGames',        ''),
       ('TimerDurationInS',                    '30',      'TimerDurationInS',                    ''),
       ('MinimumAvailableWheelEffectsForRoll', '5',       'MinimumAvailableWheelEffectsForRoll', ''),
       ('MinimumAvailableRollCountForRoll',    '1',       'MinimumAvailableRollCountForRoll',    ''),
       ('MaximumAvailableRollCountForTimer',   '999',     'MaximumAvailableRollCountForTimer',   ''),
       ('AvailableRollChangeByRoll',           '-1',      'AvailableRollChangeByRoll',           '')
ON CONFLICT (Code) DO NOTHING;
