# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a ticket grabbing automation project with two main components:

1. **AutoX.js Scripts** - JavaScript automation scripts for Android that automate ticket purchasing on Chinese ticketing platforms (MaoYan/猫眼, FenWanDao/纷玩岛, PiaoXingQiu/票星球)
2. **Spring Boot Notification Service** - Java backend service for sending email notifications when tickets become available

## Development Environment

### AutoX.js Scripts
- **Platform**: Android automation using AutoX.js
- **Language**: JavaScript
- **Runtime**: AutoX.js (https://github.com/kkevsekk1/AutoX)
- **Documentation**: http://doc.autoxjs.com/
- **Development Version**: 6.5.8

### Spring Boot Service
- **Framework**: Spring Boot 3.2.5
- **Language**: Java 21
- **Build Tool**: Maven
- **Dependencies**: Spring Web, Spring Mail, Spring DevTools

## Key Scripts

### MaoYan (猫眼) Scripts
- `MaoYanGoNew.js` - Scheduled ticket grabbing at specific times
- `MaoYanMonitor.js` - Monitors for lower-priced tickets with automatic selection
- `MaoYanGo.js` - Legacy version of ticket grabbing script

### Other Platform Scripts
- `FenWanDaoGo.js` - Ticket grabbing for FenWanDao platform
- `PiaoXingQiuGo.js` - Ticket grabbing for PiaoXingQiu platform

## Build and Run Commands

### Spring Boot Service
```bash
# Navigate to service directory
cd ticket-notice

# Build the project
mvn clean compile

# Run the application
mvn spring-boot:run

# Run tests
mvn test

# Package for production
mvn clean package
```

### AutoX.js Scripts
- Scripts are designed to run directly in AutoX.js environment
- No build process required - scripts are interpreted
- Test scripts in AutoX.js development environment before deployment

## Architecture

### AutoX.js Scripts Architecture
- Uses Android accessibility services for UI automation
- Multi-threaded approach with background monitoring threads
- Coordinate-based UI interaction with fallback mechanisms
- Webhook notification support for successful ticket grabs
- Debug mode for testing without actual purchases

### Spring Boot Service Architecture
- RESTful API with single endpoint `/notice/email`
- Email service using Spring Mail
- API key authentication via interceptors
- Configuration-based security properties
- Global exception handling

## Configuration

### Spring Boot Application
- Main configuration: `application.yml`
- Environment-specific configs: `application-{profile}.properties`
- Security settings: API key based authentication
- Email configuration: SMTP settings in application properties

### AutoX.js Scripts
- Configuration variables at top of each script
- Debug mode flags for testing
- Coordinate-based UI targeting
- Webhook URLs for notifications

## Testing

### AutoX.js Scripts
- Test scripts in AutoX.js development environment
- Use debug mode to avoid actual purchases
- Verify UI element recognition before deployment
- Test coordinate targeting on different device sizes

### Spring Boot Service
- Unit tests in `src/test/java`
- Integration tests for email service
- API endpoint testing via Postman collection provided

## Important Notes

- Scripts require Android accessibility permissions
- Coordinate-based UI interaction may need adjustment for different devices
- Email service requires proper SMTP configuration
- API keys should be properly secured in production
- All scripts include safety mechanisms to prevent unintended purchases