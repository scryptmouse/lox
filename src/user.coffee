hash = require 'password-hash'

isEmail = (email) ->
  email.match(/^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$/)

module.exports = (mongoose) ->
  UserSchema = new mongoose.base.Schema
    email:
      required: true
      type: String
      unique: true
      lowercase: true
      trim: true
      validate: [isEmail, 'invalid_email']
    password:
      required: true
      type: String
      set: hash.generate

  UserSchema.statics.hash = hash.generate
  UserSchema.methods.verify = (password) ->
    hash.verify password, this.password

  return UserSchema

