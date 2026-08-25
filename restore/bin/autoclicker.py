#!/usr/bin/env python3
"""
Autoclicker script for Hyprland
Works with Wayland compositors using pynput library
"""

import time
import threading
import argparse
import sys
from pynput.mouse import Button, Controller as MouseController
from pynput.keyboard import Key, KeyCode, Listener as KeyboardListener

class AutoClicker:
    def __init__(self):
        self.mouse = MouseController()
        self.clicking = False
        self.click_thread = None
        self.click_interval = 1.0  # Default 1 second
        self.click_button = Button.left
        self.click_position = None
        self.click_count = 0
        self.max_clicks = None
        
    def set_interval(self, interval):
        """Set click interval in seconds"""
        self.click_interval = max(0.01, float(interval))  # Minimum 10ms
        
    def set_button(self, button_name):
        """Set which mouse button to click"""
        if button_name.lower() in ['left', 'l']:
            self.click_button = Button.left
        elif button_name.lower() in ['right', 'r']:
            self.click_button = Button.right
        elif button_name.lower() in ['middle', 'm']:
            self.click_button = Button.middle
        else:
            print(f"Unknown button: {button_name}. Using left button.")
            self.click_button = Button.left
            
    def set_position(self, x, y):
        """Set specific position to click"""
        self.click_position = (int(x), int(y))
        
    def set_max_clicks(self, count):
        """Set maximum number of clicks (None for infinite)"""
        self.max_clicks = int(count) if count else None
        
    def click_loop(self):
        """Main clicking loop"""
        while self.clicking:
            if self.max_clicks and self.click_count >= self.max_clicks:
                self.stop()
                break
                
            if self.click_position:
                # Save current position
                current_pos = self.mouse.position
                # Move to target position
                self.mouse.position = self.click_position
                time.sleep(0.01)  # Small delay to ensure position is set
                
            # Perform click
            self.mouse.click(self.click_button, 1)
            self.click_count += 1
            
            print(f"Click #{self.click_count} at {self.mouse.position}")
            
            if self.click_position:
                # Restore original position
                self.mouse.position = current_pos
                
            time.sleep(self.click_interval)
    
    def start(self):
        """Start autoclicking"""
        if self.clicking:
            print("Autoclicker is already running!")
            return
            
        self.clicking = True
        self.click_count = 0
        self.click_thread = threading.Thread(target=self.click_loop)
        self.click_thread.daemon = True
        self.click_thread.start()
        print(f"Autoclicker started! Clicking every {self.click_interval}s with {self.click_button.name} button")
        if self.click_position:
            print(f"Target position: {self.click_position}")
        if self.max_clicks:
            print(f"Will stop after {self.max_clicks} clicks")
        print("Press 'q' to stop, 's' to start/stop, 'p' to pause/resume")
        
    def stop(self):
        """Stop autoclicking"""
        if not self.clicking:
            print("Autoclicker is not running!")
            return
            
        self.clicking = False
        if self.click_thread:
            self.click_thread.join(timeout=1.0)
        print(f"Autoclicker stopped! Total clicks: {self.click_count}")
        
    def toggle(self):
        """Toggle autoclicker on/off"""
        if self.clicking:
            self.stop()
        else:
            self.start()

def on_press(key, autoclicker):
    """Handle key press events"""
    try:
        if key.char == 'q':
            print("\nQuitting...")
            autoclicker.stop()
            return False  # Stop listener
        elif key.char == 's':
            autoclicker.toggle()
        elif key.char == 'p':
            if autoclicker.clicking:
                autoclicker.stop()
                print("Paused. Press 's' to resume.")
    except AttributeError:
        # Special keys (like ctrl, alt, etc.) don't have char
        pass
    return True

def main():
    parser = argparse.ArgumentParser(description='Autoclicker for Hyprland')
    parser.add_argument('-i', '--interval', type=float, default=1.0,
                      help='Click interval in seconds (default: 1.0)')
    parser.add_argument('-b', '--button', choices=['left', 'right', 'middle', 'l', 'r', 'm'],
                      default='left', help='Mouse button to click (default: left)')
    parser.add_argument('-x', '--x-pos', type=int, help='X coordinate to click at')
    parser.add_argument('-y', '--y-pos', type=int, help='Y coordinate to click at')
    parser.add_argument('-c', '--count', type=int, help='Maximum number of clicks (infinite if not specified)')
    parser.add_argument('--get-pos', action='store_true', help='Get current mouse position and exit')
    
    args = parser.parse_args()
    
    # Get current mouse position if requested
    if args.get_pos:
        mouse = MouseController()
        pos = mouse.position
        print(f"Current mouse position: x={pos[0]}, y={pos[1]}")
        return
    
    # Create autoclicker
    autoclicker = AutoClicker()
    autoclicker.set_interval(args.interval)
    autoclicker.set_button(args.button)
    
    if args.x_pos is not None and args.y_pos is not None:
        autoclicker.set_position(args.x_pos, args.y_pos)
    elif args.x_pos is not None or args.y_pos is not None:
        print("Error: Both -x and -y must be specified together")
        sys.exit(1)
        
    if args.count:
        autoclicker.set_max_clicks(args.count)
    
    print("Autoclicker ready!")
    print("Controls:")
    print("  's' - Start/Stop clicking")
    print("  'p' - Pause/Resume")  
    print("  'q' - Quit")
    print()
    
    # Set up keyboard listener
    try:
        with KeyboardListener(on_press=lambda key: on_press(key, autoclicker)) as listener:
            listener.join()
    except KeyboardInterrupt:
        print("\nInterrupted!")
        autoclicker.stop()

if __name__ == "__main__":
    main()