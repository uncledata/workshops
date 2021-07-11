alter table db.operational_db.MOCK_USERS_DATA
add updated_at timestamp;

update db.operational_db.MOCK_USERS_DATA
set updated_at = created_at
where updated_at is null;