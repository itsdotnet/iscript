# iScript

## Description

This repository contains a command-line tool for managing package setups on Linux. The tool allows you to:

- List available package setups.
- Install specific packages by running setup scripts.
- Update the tool itself.

The tool is designed to be adaptable to different Linux distributions.

## Usage

To use this tool, follow the commands below:

### List Available Packages

```bash
isc --list
```

### Setup a Package

```bash
isc --setup <package>
```

### Update the Tool

```bash
isc --update
```

### Help
```bash
isc --help
```

## Installation

1. Clone the repository:

```bash
git clone https://github.com/yourusername/iscript.git
cd iscript
```

2. Run the `start.sh` script to set up the tool:

```bash
chmod +x start.sh
./start.sh
```

3. Follow the on-screen instructions to complete the setup.

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request with your changes. Ensure that you have tested your modifications thoroughly before submitting.

1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Commit your changes and push to your fork.
4. Submit a pull request describing your changes.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
