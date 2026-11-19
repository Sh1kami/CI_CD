from app import database
with database() as db:
    db.execute('CREATE TABLE IF NOT EXISTS counter (id INTEGER PRIMARY KEY, value INTEGER NOT NULL)')
    db.execute('INSERT INTO counter VALUES (1, 0) ON CONFLICT (id) DO NOTHING')
print('Migration completed successfully')
