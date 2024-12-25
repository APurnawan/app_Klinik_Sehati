from app import app, db, User  # Import the Flask app, db instance, and User model

username = "Admin"
password = "admin123"
level = "Admin"

with app.app_context():  # Ensure that the application context is active
    new_user = User(username=username, password=password, level=level)
    db.session.add(new_user)
    db.session.commit()

