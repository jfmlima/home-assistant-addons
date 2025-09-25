# Home Assistant Add-on: Shelly Manager

Local management for Shelly IoT devices without cloud connectivity.

## About

Shelly Manager allows you to manage your Shelly devices directly from Home Assistant without connecting them to the Shelly Cloud. This addon provides both a web interface and REST API for complete device management.

## Features

- 🔍 **Device Discovery**: Scan and discover Shelly devices on your network using mDNS and network scanning
- ⚡ **Firmware Management**: Update firmware from stable/beta channels
- 🔧 **Device Configuration**: Manage device settings and configurations
- 📊 **Bulk Operations**: Perform actions on multiple devices simultaneously
- 🎛️ **Component Actions**: Control switches, covers, lights, and other components
- 📈 **Status Monitoring**: Real-time device status and health monitoring

## Installation

1. Add this repository to your Home Assistant Supervisor add-on store
2. Install the "Shelly Manager" add-on
3. Configure your network settings in the add-on configuration
4. Start the add-on
5. Access the web interface through the "Web UI" button or via the sidebar panel

## Configuration

### Basic Configuration

```yaml
device_ips:
  - "192.168.1.100"
  - "192.168.1.101"
predefined_ranges:
  - start: "192.168.1.1"
    end: "192.168.1.254"
timeout: 3.0
max_workers: 50
log_level: "info"
```

### Configuration Options

| Option              | Type   | Default     | Description                              |
| ------------------- | ------ | ----------- | ---------------------------------------- |
| `device_ips`        | list   | `[]`        | List of known Shelly device IP addresses |
| `predefined_ranges` | list   | See example | Network ranges to scan for devices       |
| `timeout`           | float  | `3.0`       | Connection timeout in seconds            |
| `max_workers`       | int    | `50`        | Maximum concurrent workers for scanning  |
| `log_level`         | string | `info`      | Log level (debug, info, warning, error)  |

### Network Ranges

Define network ranges where your Shelly devices are located:

```yaml
predefined_ranges:
  - start: "192.168.1.1"
    end: "192.168.1.254"
  - start: "10.0.0.1"
    end: "10.0.0.100"
```

## Usage

### Web Interface

1. Click "Open Web UI" or access via the Home Assistant sidebar
2. Use the **Scan** button to discover devices on your network
3. View device status, firmware versions, and configurations
4. Perform individual device actions or bulk operations
5. Update firmware, reboot devices, or modify configurations

### API Access

The addon also provides a REST API accessible at port 8000 with OpenAPI documentation available.

Key endpoints:

- `GET /api/health` - Service health check
- `GET /api/devices/scan` - Discover devices
- `GET /api/devices/{ip}/status` - Get device status
- `POST /api/devices/{ip}/update` - Update firmware
- `POST /api/devices/bulk/update` - Bulk firmware updates

Access the API documentation by clicking "Open Web UI" and navigating to `/docs`.

## Network Requirements

- **Host Network**: This addon uses host networking to enable mDNS discovery
- **Network Access**: Requires access to your local network where Shelly devices are located
- **Ports**: Uses ports 8000 (API) and 8080 (Web UI) internally

## Troubleshooting

### Device Discovery Issues

If devices are not being discovered:

1. **Check Network Configuration**: Ensure the predefined ranges match your network setup
2. **Verify Host Network**: The addon needs host network access for mDNS discovery
3. **Firewall Settings**: Make sure multicast traffic is allowed on your network
4. **Device Accessibility**: Test if devices are reachable from Home Assistant host

### Common Solutions

- **Check logs** for connection errors or timeouts
- **Verify network ranges** in configuration match your actual network
- **Increase timeout** if you have slow network or many devices

### Logs

Enable debug logging for troubleshooting:

```yaml
log_level: "debug"
```

## Support

- 📖 **Documentation**: [GitHub Repository](https://github.com/jfmlima/shelly-manager)
- 🐛 **Issues**: [Report Issues](https://github.com/jfmlima/shelly-manager/issues)
- 💬 **Discussions**: [GitHub Discussions](https://github.com/jfmlima/shelly-manager/discussions)

## License

MIT License - see [LICENSE](https://github.com/jfmlima/shelly-manager/blob/main/LICENSE) file.

## Disclaimer

**USE AT YOUR OWN RISK**: This software is provided "as is" without warranty of any kind. By using this addon, you acknowledge that you do so at your own risk.
