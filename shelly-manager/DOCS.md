# Home Assistant Add-on: Shelly Manager

Local management for Shelly IoT devices without cloud connectivity.

## About

Shelly Manager allows you to manage your Shelly devices directly from Home Assistant without connecting them to the Shelly Cloud. This addon provides both a web interface and REST API for complete device management.

## Features

- **Device Discovery**: Scan and discover Shelly devices on your network using mDNS and network scanning
- **Firmware Management**: Update firmware from stable/beta channels
- **Device Configuration**: Manage device settings and configurations
- **Bulk Operations**: Perform actions on multiple devices simultaneously
- **Component Actions**: Control switches, covers, lights, and other components
- **Status Monitoring**: Real-time device status and health monitoring
- **Credential Management**: Securely store and manage device passwords with encryption

## Installation

1. Add this repository to your Home Assistant Supervisor add-on store
2. Install the "Shelly Manager" add-on
3. Generate a secret key and configure the add-on (see Configuration below)
4. Start the add-on
5. Access the web interface through the "Web UI" button or via the sidebar panel

## Configuration

### Basic Configuration

```yaml
secret_key: "your-generated-fernet-key"
timeout: 3.0
max_workers: 50
log_level: "info"
```

### Generating a Secret Key

The `secret_key` is required for encrypting stored device credentials. Generate one using Python:

```bash
python -c "from cryptography.fernet import Fernet; print(Fernet.generate_key().decode())"
```

Copy the output (a base64-encoded string) and paste it into the `secret_key` configuration field.

**Important**: Keep your secret key safe. If you lose it, you will need to re-enter all device credentials.

### Configuration Options

| Option        | Type   | Default | Description                              |
| ------------- | ------ | ------- | ---------------------------------------- |
| `secret_key`  | string | `""`    | Fernet encryption key for credentials (required) |
| `timeout`     | float  | `3.0`   | Connection timeout in seconds            |
| `max_workers` | int    | `50`    | Maximum concurrent workers for scanning  |
| `log_level`   | string | `info`  | Log level (debug, info, warning, error)  |

## Managing Device Credentials

If your Shelly devices are password-protected, you can manage credentials through the web interface:

1. Open the Shelly Manager web UI
2. Navigate to the **Credentials** section
3. Add credentials for specific devices (by MAC address) or set a global fallback credential
4. Credentials are stored encrypted and used automatically when communicating with devices

### Credential Priority

1. Device-specific credential (matched by MAC address)
2. Global fallback credential (MAC: `*`)
3. No authentication (for devices without password protection)

## Usage

### Web Interface

1. Click "Open Web UI" or access via the Home Assistant sidebar
2. Use the **Scan** button to discover devices on your network (enter IP ranges or CIDR notation)
3. View device status, firmware versions, and configurations
4. Perform individual device actions or bulk operations
5. Update firmware, reboot devices, or modify configurations

### API Access

The addon also provides a REST API accessible at port 8000 with OpenAPI documentation available.

Key endpoints:

- `GET /api/health` - Service health check
- `POST /api/devices/scan` - Discover devices
- `GET /api/devices/{ip}/status` - Get device status
- `POST /api/devices/{ip}/update` - Update firmware
- `POST /api/devices/bulk/update` - Bulk firmware updates
- `GET /api/credentials` - List stored credentials
- `POST /api/credentials` - Add/update credentials

Access the API documentation by clicking "Open Web UI" and navigating to `/docs`.

## Network Requirements

- **Host Network**: This addon uses host networking to enable mDNS discovery
- **Network Access**: Requires access to your local network where Shelly devices are located
- **Ports**: Uses ports 8000 (API) and 8080 (Web UI) internally

## Troubleshooting

### Device Discovery Issues

If devices are not being discovered:

1. **Verify Host Network**: The addon needs host network access for mDNS discovery
2. **Firewall Settings**: Make sure multicast traffic is allowed on your network
3. **Device Accessibility**: Test if devices are reachable from Home Assistant host

### Authentication Issues

If devices are returning authentication errors:

1. **Check Credentials**: Ensure credentials are stored for the device in the Credentials section
2. **Verify Password**: Make sure the password matches what's configured on the device
3. **Check Logs**: Enable debug logging to see authentication attempts

### Common Solutions

- **Check logs** for connection errors or timeouts
- **Increase timeout** if you have slow network or many devices

### Logs

Enable debug logging for troubleshooting:

```yaml
log_level: "debug"
```

## Support

- **Documentation**: [GitHub Repository](https://github.com/jfmlima/shelly-manager)
- **Issues**: [Report Issues](https://github.com/jfmlima/shelly-manager/issues)
- **Discussions**: [GitHub Discussions](https://github.com/jfmlima/shelly-manager/discussions)

## License

MIT License - see [LICENSE](https://github.com/jfmlima/shelly-manager/blob/main/LICENSE) file.

## Disclaimer

**USE AT YOUR OWN RISK**: This software is provided "as is" without warranty of any kind. By using this addon, you acknowledge that you do so at your own risk.
