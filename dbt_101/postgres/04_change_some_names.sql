
update db.operational_db.MOCK_USERS_DATA
set
    first_name = first_name  || ' changed',
    updated_at = now()
where mock_users_data.id < 10;