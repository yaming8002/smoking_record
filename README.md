
# Smoking Record App
This application aims to track and analyze smoking habits, assisting smokers in gradually understanding and reducing their smoking habits through data recording and analysis.

## Table of Contents
- [Smoking Record App](#smoking-record-app)
  - [Table of Contents](#table-of-contents)
  - [Features](#features)
  - [Database Schema](#database-schema)
  - [Getting Started](#getting-started)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
  - [Usage](#usage)
  - [License](#license)
  - [Contact](#contact)

## Features
- **Record Smoking Instances:** Record the time and duration of each smoking instance.
- **Set Interval Time:** Users can set a specific interval time between smoking instances. This feature helps in gradually reducing the frequency of smoking by encouraging users to wait longer before their next cigarette.
- **Reports:** Generate daily, weekly, and monthly reports to display the number of cigarettes smoked and total time spent smoking. Reports will also track progress in extending the interval time between smoking instances.
- **Main Pages:**
  - **Top Menu:** Access data-related options and settings.
  - **Home Page:** View a main button showing the current time and time since last smoking instance, and summaries of daily and weekly smoking data. Also displays the next allowable smoking time based on the set interval.
  - **Add Smoking Record:** Record the total time and number of cigarettes smoked. Input the time of the next smoking instance according to the set interval.
  - **Report Summary:** Toggle between daily and weekly views, and browse through a date range selector. Includes statistics on adherence to the set smoking intervals.
  - **Settings Page:** Configure the day-change time, usual smoking time, language preferences, and editing and subscription options. Additionally, set and adjust the smoking interval time to suit individual goals for reducing smoking frequency.

## Database Schema
- **SmokingStatus:** Managed by `SmokingStatus.dart`.
- **SummaryDay:** Managed by `Summary.dart`, primarily aggregates daily data.

## Getting Started

### Prerequisites
Ensure that you have Flutter installed on your machine.

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/smoking_record.git
   ```
2. Navigate to the project directory:
   ```bash
   cd smoking_record
   ```

## Usage
Run the application:
```bash
flutter run
```

## License
Distributed under the Apache License 2.0. See `LICENSE` for more information.

## Contact
For more information, please contact yamingworking@gmail.com.
