from flask import Flask, render_template, redirect, url_for, session, request, flash, jsonify, make_response
from flask_sqlalchemy import SQLAlchemy
from sqlalchemy import func
from flask_bcrypt import Bcrypt
from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, SelectField
from wtforms.validators import InputRequired
from flask_bootstrap import Bootstrap 
from functools import wraps
from flask_migrate import Migrate
import datetime
from sqlalchemy import or_
import pdfkit
from datetime import date
from decimal import Decimal
from sqlalchemy.exc import SQLAlchemyError
from datetime import datetime



app = Flask(__name__)

app.config['SECRET_KEY'] = '$#FHenfge24'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://root@localhost/dbklinik'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db = SQLAlchemy(app)
migrate = Migrate(app, db)
bcrypt = Bcrypt(app)
bootstrap = Bootstrap(app)

from klinik.backend import routes
