USE team_netflix;
SOURCE team_netflix.sql;

INSERT INTO account (id, email, password, phone_number, subscription_id, account_created)
VALUES 
(102, michael.starkb@gmail.com, 0000, 917-854-4008, 1002, 10-28-2026),
(103, john.doe@gmail.com, 1234534368, 999-888-9988, 1003, 10-28-2026);

INSERT INTO subscription (id, subscription_type, subscription_price, subscription_duration)
VALUES
(1, premium, 20.00, 1),
(2, basic, 10.00, 1);