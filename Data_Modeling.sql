-- Data Modeling

CREATE TABLE events (
    eventhub_id INT PRIMARY KEY,
    device_id INT NOT NULL,
    device_type INT NOT NULL,
    logged_time TIMESTAMP NOT NULL,
    p1 FLOAT,
    p2 FLOAT,
    p3 FLOAT,
    p4 TEXT,
    p5 BOOLEAN,
    p6 BOOLEAN,
    p7 TIMESTAMP,
    p8 FLOAT,
    p9 FLOAT,
    p10 FLOAT
    
);

CREATE TABLE companies (
    company_id INT PRIMARY KEY,
    eventhub_id INT REFERENCES events(eventhub_id)
);

CREATE TABLE alarms (
    alarm_id INT PRIMARY KEY,
    alarm_type TEXT,
    event_id INT REFERENCES events (eventhub_id) ,
    alarm_Time TIMESTAMP 
   
);

CREATE TABLE devices (
    device_id INT NOT NULL REFERENCES events(device_id),
    device_type INT   
);

-- It would be helpful to:
    --  have more information about the events, such as: start time AND end time, what triggered the event
    --  know more about the company, such as: name, location, contact information, 
    --  have more information about the alarms, such as: urgency, description 
    --  have more information about the devices such: the device name, the manufacturer, the location, etc.

-- Assumptions made: 
--      A single event can be associated with multiple companies 
--      Columns P1-p10 measure different items - possibly sensor readings or status indicators, and can be null(may not apply to all events)
--      Timezones are consistent - Logged_time uses UTC format. If different timezones are involved, you'd need a Timezone field
