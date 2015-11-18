---
comments: true

published: true
title: Configuring Nginx with SSL
date: 2014-01-17 08:00
excerpt: "How to configure Nginx to use SSL"
permalink: /notebook/2014/01/nginx-with-ssl

tags: development web server
---

Work on my [final year project](/notebook/2013/08/server-observer/ "Server Observer - Server Monitoring made Simple") recently I've had to configure SSL with Nginx, as the application will only be available on HTTPS. This is the first time I've had to carry out this task, and after finding the RadidSSL instructions for Nginx to be somewhat out-of-date I decided to publish this as a note to myself in the future of the correct configuration.

I bought the certificate from [ServerTastic](https://www.servertastic.com "ServerTastic SSL"), as recommended by [multiple people on Twitter](https://twitter.com/danielsgroves/status/420205640175194112 "SSL providor recommendations on Twitter"). Once going through the process of buying and registering my RapidSSL certificate I ended up on a page with the options to download my PEM and Private Key files. At the same time they emailed my a *Web Server Certificate* and a *Intermediate CA*.

With Nginx I only needed the `.key` file, and the two keys in the email. I found the `.pem` file to be different to the one that I was required to make by Nginx. In this email there was a link to a set of [instructions for configuring Nginx with SSL](https://knowledge.rapidssl.com/support/ssl-certificate-support/index?page=content&actp=CROSSLINK&id=SO17664 "Nginx Installation Instructions for Nginx server"). The terminology in these simply does not line up with the keys provided, and the instructions for building the `.pem` file didn't seem quite right.

## Installing the Keys

Firstly, it's quickest to start with the private key file you downloaded from the website. Copy this to `/etc/ssl`, where I chose to rename it to match my domain name. Secondly we need to build the `.pem` file. This is easily done, simply create a new text file and copy in the *Web Server Certificate* followed by the *Intermediate CA*. Make sure there is no additional white space, aisde form one line break between the two keys. They should look similar to below.

```
-----BEGIN CERTIFICATE-----
..............................................
-----END CERTIFICATE-----
-----BEGIN CERTIFICATE-----
..............................................
-----END CERTIFICATE-----
```

Once this is done, save the file with the `.pem` extension and copy it to `/etc/ssl` on your server. Once this is done it's a simple case of configuring Nginx. A basic installation could look as follows.

```
server {
    listen 443 default_server ssl;

    ssl_certificate /etc/ssl/your_pem_file.pem;
    ssl_certificate_key /etc/ssl/your_key_file.key;

    ssl_prefer_server_ciphers On;
    ssl_protocols SSLv3 TLSv1 TLSv1.1 TLSv1.2;
    ssl_ciphers ECDH+AESGCM:DH+AESGCM:ECDH+AES256:DH+AES256:ECDH+AES128:DH+AES:ECDH+3DES:DH+3DES:RSA+AES:RSA+3DES:!aNULL:!MD5:!DSS;

    server_name your_domain;
}
```

On top of this you would need to configure your actual site such as where to find the PHP server, if that's your thing. I also replaced my port 80 settings with the following snippet, which redirects all traffic to HTTPS.

```
server {
    listen 80;
    server_name your_domain;
    rewrite ^ https://$server_name$request_uri? permanent;
}
```

## Testing the Certificate

Testing is very easily done. I used [SSL Labs](https://www.ssllabs.com/ssltest/ "") certificate tester, which is best described by the SSL Labs team.

> This free online service performs a deep analysis of the configuration of any SSL web server on the public Internet.

It's very easy to use. Simply type your domain name into the input and hit enter. Their service will begin to analyse your SSL security, it can take a few minutes to complete but keeps you informed of the progress as it checks various encryption types and configuration settings. Once completed it will rate your certificate so that you can assess how good the protection is, and then make adjustments as required.

<figure>
    <img src="/assets/development/2014-01-16-nginx-with-ssl/ssllabs-approval.png" alt="'A' rated SSL encryption from the SSL Labs tester" />
    <figcaption>'A' rated SSL encryption from the SSL Labs tester</figcaption>
</figure>

## Summary

As demonstrated by this post, configuring SSL with Nginx is pretty easy. Before finishing off I should make it clear that I am by no means a security expert and so cannot be held liable for anything that goes wrong as a result of following these instructions. I've only really published them for my own reference.

Naturally, feel free to post any questions you have and I'll endeavour to do my best to answer them.
