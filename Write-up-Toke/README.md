# Write-up Toke IceCTF 2016

In this section you will find the write-up for the Toke challenge in IceCTF 2016. The website for the challenge can be found on:
> http://toke.vuln.icec.tf/

This website contains two more pages next to the homepage, which are Login and Register. First: Register a user on the website, to make sure you are able to login and explore the contents of the userpanel.
Any username or password that has not been taken already is accepted. I registered as hansworst5.
After logging in you will find nothing on the panel, except for a welcome message about the website shutting down.

# Burp Suite

I logged in again, but now with Burp Suite set up as a proxy server. You can set a proxy server of Firefox in Preferences -> Advanced -> Network -> Settings. I used the following configuration:
> Manual Proxy Configuration. HTTP Proxy: 127.0.0.1. Port: 8080.

Make sure burpsuite is listening on Port 8080, otherwise you won't be able to intercept the traffic or browse the internet. Burp Suite intercepted the following interesting packet:

>GET /dashboard HTTP/1.1 <br/>
>Host: toke.vuln.icec.tf <br/>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0 <br/>
Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8 <br/>
Accept-Language: en-US,en;q=0.5 <br/>
Accept-Encoding: gzip, deflate <br/>
Referer: http://toke.vuln.icec.tf/login <br/>
Cookie: __cfduid=d771d94f73532a452a835c261090a5e841471282849; _ga=GA1.2.1694381075.1471282851; jwt_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmbGFnIjoiSWNlQ1RGe2pXN190MEszbnNfNFJlX25PX3AxNENFX2ZPUl81M0NyRTdTfSIsInVzZXIiOiJoYW5zd29yc3Q1In0.ikOBIuQg7PKG3PMGOn8IYXyp5kHY6I99PVi1TwLWRIA; session=eyJ1c2VyIjo1MzcxfQ.CsELpQ.lRAWBu1K4Y7lj7KZBnT0VhkA6H8 <br/>
Connection: close <br/>

In this HTTP GET-request a Cookie is set for the user to login. In this case the cookie contains a jwt_token, which is a JSON web token used for transmission of secured information between two parties in a JSON object.
Those kind of tokens can be decoded using several websites. I used:
> jwt.io

The string to decode from jwt_token:
> eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJmbGFnIjoiSWNlQ1RGe2pXN190MEszbnNfNFJlX25PX3AxNENFX2ZPUl81M0NyRTdTfSIsInVzZXIiOiJoYW5zd29yc3Q1In0.ikOBIuQg7PKG3PMGOn8IYXyp5kHY6I99PVi1TwLWRIA

The decoded data:
Header
> {
>  "typ": "JWT",
>  "alg": "HS256"
>}

Data
> {
>  "flag": "IceCTF{jW7_t0K3ns_4Re_nO_p14CE_fOR_53CrE7S}",
>  "user": "hansworst5"
> }

The flag was in the jwt_token and is:
> IceCTF{jW7_t0K3ns_4Re_nO_p14CE_fOR_53CrE7S}
