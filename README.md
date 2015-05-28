# JWT Server Demo

## Summary

This is a Rails API which demonstrates how to use JWT. The JWT is used in below cases:

- Token based authentication
- Reset password

## Technical Details

You can check `spec/requests` to know how to use the APIs.

I put most of the logic in standalone Ruby files, they're:

- `lib/token_processor.rb`
- `app/services/authenticate_user.rb`
- `app/services/login_user.rb`
- `app/services/reset_password.rb`

## References

Some libaries:

- [JWT](http://jwt.io)
- [ruby-jwt](https://github.com/progrium/ruby-jwt)
- [angular-jwt](https://github.com/auth0/angular-jwt)

Also read:

- [JSON Web Token: The Useful Little Standard You Haven't Heard About](http://www.intridea.com/blog/2013/11/7/json-web-token-the-useful-little-standard-you-haven-t-heard-about)
- [Handling JWTs on Angular is finally easier!](https://auth0.com/blog/2014/10/01/handling-jwts-on-angular-is-finally-easier/)
- [Cookies vs Tokens. Getting auth right with Angular.JS](https://auth0.com/blog/2014/01/07/angularjs-authentication-with-cookies-vs-token/)
- [The Anatomy of a JSON Web Token](https://scotch.io/tutorials/the-anatomy-of-a-json-web-token)
