# MySQL SequelPro error fix

In case you get the below error:

![](https://education-team-2020.s3-eu-west-1.amazonaws.com/data-analytics/setup_instructions/unit_1_sqlpro_error_screen_shot.png)

**What does this error mean?**

What is `caching_sha2_password` Authentication Plugin?
The `caching_sha2_password` is MySQL’s latest authentication plugin which brings some major advancements to the connection encryption, compared to the other authentication mechanisms. The first is, an in-memory cache for faster authentication. Next is a RSA-based password exchange that is independent of the SSL library against which MySQL is linked. And finally, it supports Unix socket-files and shared-memory protocols. You can read more about its features [here](https://dev.mysql.com/doc/refman/8.0/en/caching-sha2-pluggable-authentication.html).

**Why I can’t connect to MySQL 8.0?**

The reason for this is while MySQL 8.0 uses `caching_sha2_password` as the [default authentication plugin](https://mysqlserverteam.com/mysql-8-0-4-new-default-authentication-plugin-caching_sha2_password/), your MySQL client hasn’t been compatible with it yet. It uses the older versions of _libmysqlclient_ which do not support this `caching_sha2_password` plugin. Thus it failed to connect.

For example, Sequel Pro users have been experiencing this due to the fact that Sequel Pro hasn’t supported MySQL 8 ([issue #2699](https://github.com/sequelpro/sequelpro/issues/2699)) and the `caching_sha2_password` plugin is missing ([issue 3037](https://github.com/sequelpro/sequelpro/issues/3037)).

**Solution:**

Start mysql in terminal. Use the command:

```shell
$ ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY ‘your-password’;
```

Change the password from `<your-password>` to the password that you are already using for mysql user.

If that does not work, try this:

Create a new user as shown below and use `mysql -u root -p ` to login to your root account

```shell
$ CREATE USER ‘nativeuser’@’localhost’IDENTIFIED WITH mysql_native_password BY ‘password’;
```

After you have added the new user, this user might not have all the permissions (to create a database or work on existing ones).

1. Check if the new user was created:

```shell
$ SELECT User FROM mysql.user;
```

2. Grant privileges to the new user

```shell
$ GRANT ALL PRIVILEGES ON *.* TO ‘<newusername>'@'%';
```

This will create a new super user.

Or use

```shell
$ GRANT ALL PRIVILEGES ON database_name.* TO ‘username'@'localhost';
```

to grant privileges only for a specific database.

3. Exit the root user.
4. Restart the server using `mysql.server restart`
5. Login with the new user. Go to Sequel pro and provide the credentials for the new user.
