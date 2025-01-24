# LScripts

## Overview
LScripts is a collection of useful scripts to automate various tasks and improve productivity.

## Features
- Task automation
- Productivity enhancement
- Easy to use

## Installation
Clone the repository:
```bash
git clone https://github.com/lordgaruda/LScripts.git
```

Navigate to the project directory:
```bash
cd LScripts
```

## For ActiveDirectory (Windows Server)
You might need to adjust your execution policy to allow running scripts:
```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```

## For UnixCmdLog you can use crontab for automatic run at specific time
Suppose you need to run that script at every hour.
```
crontab -e
```
Then Make a new cron tab.
```
* 1 * * * bash cmdlog.sh
```

## USB Restrict in Windows Server
To revert changes, you can delete the GPO

## Contributing
Contributions are welcome! Please fork the repository and create a pull request.

## License
This project is licensed under the MIT License.

## Contact
For any questions or suggestions, please open an issue.
