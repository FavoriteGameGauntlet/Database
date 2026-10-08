INSERT INTO defaults.SystemParameters (Code, DefaultValue, Name, Description)
VALUES ('MinimumNumberOfWishlistGames',        '3',       'MinimumNumberOfWishlistGames',        ''),
       ('TimerDurationInS',                    '30',      'TimerDurationInS',                    ''),
       ('MinimumAvailableWheelEffectsForRoll', '5',       'MinimumAvailableWheelEffectsForRoll', '')
ON CONFLICT (Code) DO NOTHING;
