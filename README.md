# DevOps Intern Assignment

---

## 🎯 Project Overview  
This repository contains my complete solution for the **DevOps Intern Assignment**.  

It demonstrates key DevOps skills: Linux user management, cloud infrastructure (AWS EC2), web server deployment, automated monitoring via Bash + cron, and log integration with AWS CloudWatch.  

---

## 📁 Repository Structure

```
.
├── README.md
├── scripts/
│   └── system_report.sh
├── config/
│   └── cron configuration.txt
└── screenshots/
    ├── Part - 1.png
    ├── Part - 2.png
    ├── Part - 3.png
    ├── Part - 4 D-1.1.png
    ├── Part - 4 D-1.2.png
    ├── Part - 4 D-1.3.png
    ├── Part - 4 D-2.1.png
    ├── Part - 4 D-2.2.png
    ├── cron config.png
    └── system_report.png
```


## 🧩 Part 1 – Environment Setup  
**Goal:** Launch an Ubuntu EC2 instance, create user `devops_intern` with passwordless sudo, and rename the hostname.  
### Steps:  
1. Launch a **t2.micro** Ubuntu instance (Free Tier eligible) on AWS.
   
2. SSH into the instance:  
ssh -i <keypair>.pem ubuntu@<public-ip>
   
3. Create the new user and grant sudo without password:
sudo adduser devops_intern  
echo "devops_intern ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/devops_intern  
sudo chmod 440 /etc/sudoers.d/devops_intern  

4. Change the hostname (e.g., yourname-devops):
sudo hostnamectl set-hostname yourname-devops

5. Verify:
hostname  
cat /etc/passwd | grep devops_intern  
sudo -u devops_intern -i  
sudo whoami

📷 See screenshot:
![Part 1](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%201.png)

## 🌐 Part 2 – Simple Web Service Setup
**Goal:** Install Nginx and serve a custom HTML page at /var/www/html/index.html that includes: your name, instance ID (from AWS metadata), and server uptime.
### Steps:
1. Install Nginx:
sudo apt update && sudo apt install -y nginx  
sudo systemctl enable nginx  
sudo systemctl start nginx  

2. Create the HTML page:
INSTANCE_ID=$(curl -s http://169.254.169.254/latest/meta-data/instance-id)  
UPTIME=$(uptime -p)  
sudo tee /var/www/html/index.html
 
3. Open a browser and navigate to http://public-ip
   
📷 See screenshot:
![Part 2](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%202.png)

## 📊 Part 3 – Monitoring Script & Cron
**Goal:** Create /usr/local/bin/system_report.sh to output system metrics (date/time, uptime, CPU %, memory %, disk usage, top 3 CPU processes), and schedule it with a cron job running every 5 minutes.
### Steps:

1. Script (see scripts/system_report.sh in this repo).
2. Cron entry (see config/cron configuration.txt):
*/5 * * * * /usr/local/bin/system_report.sh >> /var/log/system_report.log 2>&1
3. After at least two runs, /var/log/system_report.log contains multiple entries.

📷 See screenshots:

System Report Script:
![System Report](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/system_report.png)

Script Log Output:
![Part 3](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%203.png)

## ☁️ Part 4 – AWS Integration with CloudWatch Logs
**Goal:** Stream your log file (/var/log/system_report.log) into AWS CloudWatch Logs, under log group /devops/intern-metrics and log stream system_report.
### Steps:

1. Create log group & stream using AWS CLI:
aws logs create-log-group --log-group-name /devops/intern-metrics  
aws logs create-log-stream --log-group-name /devops/intern-metrics --log-stream-name system_report  
Configure and start the Amazon CloudWatch Agent to send your log file to the destination above.

2. In AWS Console → CloudWatch → Logs → /devops/intern-metrics → system_report, you can monitor real-time entries of your system reports.

📷 See screenshots:

CLI/agent Setup:
![Part 4 D-1.1](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%204%20D-1.1.png)

![Part 4 D-1.2](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%204%20D-1.2.png)

![Part 4 D-1.3](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%204%20D-1.3.png)


CloudWatch Console View:
![Part 4 D-2.1](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%204%20D-2.1.png)

![Part 4 D-2.2](https://raw.githubusercontent.com/mokshith1010/devops-assignment/main/screenshots/Part%20-%204%20D-2.2.png)

## ✅ Part 5 – Documentation & Cleanup
**Goal:** Provide detailed documentation of your setup steps (this README) and terminate any AWS resources after completion.
### Reproduction Steps:

1. Clone this repo.
2. Launch an Ubuntu t2.micro EC2 instance.
3. Follow the steps in Parts 1–4 as described above.

### Cleanup:

1. Terminate the EC2 instance.
2. Delete log group /devops/intern-metrics in CloudWatch.
3. Ensure no active AWS resources remain.


## 🔧 Bonus Features:
Email Alert: The monitoring script includes an email alert if disk usage exceeds 80%.
Automated Logging: The CloudWatch Agent automatically streams the system log into CloudWatch for real-time monitoring.


## 📝 Summary
This submission demonstrates strong coverage of:

-Linux fundamentals (user management, hostname, cron jobs)

-Cloud infrastructure (AWS EC2, metadata)

-Web service deployment (Nginx)

-Automation and monitoring (Bash scripts, cron)

-Cloud logging integration (AWS CloudWatch)

-Clear, reproducible documentation


Repository URL: https://github.com/mokshith1010/devops-assignment
