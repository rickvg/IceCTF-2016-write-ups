# Write-up Flag Storage IceCTF 2016

In this challenge it is required to open webpage: http://flagstorage.vuln.icec.tf/.
This is a login page for the flag storage. A guess is that: If logged in, the flag will be shown.

I assumed the website uses MySQL, so the form would be vulnerable to SQL-injection. The first guess of the SQL-query is as follows:
> SELECT user,password FROM users WHERE user = '$input1' and password = '$input2'

If the PHP-file only checks if the SELECT-statement returned true, it is possible to apply the following SQL-injection:
> ' or 1=1#

This results in the guessed SQL-injection string:
> SELECT user,password FROM users WHERE users = '' or 1=1#' and password = '$input2'

Why would this method work if the PHP-file only checks if the SELECT-statement returned true and the guessed SQL-query is correct?
The #-character is a comment character in SQL. This means all text after # is commented, so this part of the SQL-query is not being processed by MySQL.

This results in the following SQL-query:
> SELECT user,password FROM users WHERE user = '' or 1=1

This statement is ALWAYS true as 1=1. The WHERE-clause also contains an OR which means it checks either if user = '' or 1 = 1. The second one is always true, so the statement would return true.

After entering this SQL-injection ' or 1=1# in the username form and clicking Log In, the user is logged in. On the same page, the flag is shown:
> IceCTF{why_would_you_even_do_anything_client_side}
