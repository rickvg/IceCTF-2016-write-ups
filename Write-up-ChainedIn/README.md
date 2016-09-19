# Write-up ChainedIn IceCTF 2016

"I keep getting so much spam from this website. Can you leak the admin password so I can put a stop this nonsense? I made an account for you to help you break in, the username is agent1568 and the password is agent1568"

The website URL was:
> http://chainedin.vuln.icec.tf/

The website shows 2 buttons and information in the right lower corner. Both buttons lead to the login page, where we can login using the given credentials. (agent1568:agent1568)
After logging in the website shows "Welcome back Agent1568". According to the information we have from the webpage, the website is running on MongoDB and AngularJS. This means, SQL injection won't work here as MongoDB does use SQL.

Using Burp Suite I tried a known MongoDB injection, where I can login as another user.
The attempt resulted in the following POST-request to the ChainedIn login page:

>POST /login HTTP/1.1 <br/>
Host: chainedin.vuln.icec.tf <br/>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0 <br/>
Accept: application/json, text/plain, / <br/>
Accept-Language: en-US,en;q=0.5 <br/>
Accept-Encoding: gzip, deflate <br/>
Content-Type: application/json;charset=utf-8 <br/>
Referer: http://chainedin.vuln.icec.tf/login <br/>
Content-Length: 51 <br/>
Connection: close <br/>
{"user": {"$gt": ""},"pass": {"$gt": ""}}

Note that the data has been changed in the POST-request. The original POST-request is shown below:

> POST /login HTTP/1.1 <br/>
Host: chainedin.vuln.icec.tf <br/>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101 Firefox/45.0 <br/>
Accept: application/json, text/plain, */* <br/>
Accept-Language: en-US,en;q=0.5 <br/>
Accept-Encoding: gzip, deflate <br/>
Content-Type: application/json;charset=utf-8 <br/>
Referer: http://chainedin.vuln.icec.tf/login <br/>
Content-Length: 50 <br/>
Connection: close <br/>
{"user":"admin","pass":"hellotherethisispassword"}

After clicking forward using the modified POST-request I received the message:
>Welcome back Administrator!

What does the changed data do? $gt is known within MongoDB as a greater than operator. The syntax is: {field: {$gt: value} }. Using this method MongoDB selects the data from the user field where the value is bigger than "" (an empty string).
This is always true. Same goes for the password.

Now, I need the password of the administrator. Instead of $gt, I used $regex to do the job. $regex checks whether the field in the MongoDB table contains the string given. If that's the case, it will log you in and return "Welcome Back Administrator".
Using this knowledge, I have set up a bash script which is added to this repository.

What does the bashscript do?
* Brute forces the password using the MongoDB $regex function and a known alphabet, containing only capital & non-capital alphabetic letters, digits and the special characters _}{
* Checks if the given string matches the password in the MongoDB table. If so, it saves the current value and adds another character (until character = })

After approximately 3-4 minutes the password was guessed, which (if IceCTF{ is added to it) is also the flag:
> IceCTF{I_thOugHT_YOu_coulDNt_inJeCt_noSqL_tHanKs_monGo}
