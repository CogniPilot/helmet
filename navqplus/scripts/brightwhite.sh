#!/bin/bash
ros2 topic pub -t 1 /cerebri/in/led_array synapse_msgs/msg/LEDArray "{led:[{index: 0, r: 255, g: 255, b: 255}, {index: 1, r: 255, g: 255, b: 255}, {index: 2, r: 255, g: 255, b: 255}, {index: 3, r: 255, g: 255, b: 255}, {index: 4, r: 255, g: 255, b: 255}, {index: 5, r: 255, g: 255, b: 255}, {index: 6, r: 255, g: 255, b: 255}, {index: 7, r: 255, g: 255, b: 255}, {index: 8, r: 255, g: 255, b: 255}, {index: 9, r: 255, g: 255, b: 255}, {index: 10, r: 255, g: 255, b: 255}, {index: 11, r: 255, g: 255, b: 255}]}"