#!/usr/bin/env python3
"""Test terminal support for OSC 9;4 progress bar sequences.

Sequence form: ESC ] 9 ; 4 ; <state> ; <progress> ST
  state 0 = remove progress (off)
  state 1 = default/normal (progress 0-100)
  state 2 = error state (red)
  state 3 = indeterminate (pulsing/indefinite), progress ignored
  state 4 = warning/paused (yellow)

ST (string terminator) is BEL (\a) or ESC \\. We use ESC \\.

Ref: https://learn.microsoft.com/en-us/windows/terminal/tutorials/progress-bar-sequences

Usage examples:
  ./test-osc94-progress.py                            # runs all: indeterminate -> normal -> warning -> error
  ./test-osc94-progress.py off
  ./test-osc94-progress.py indefinite --hold 5
  ./test-osc94-progress.py normal --step 2 --delay 0.05
  ./test-osc94-progress.py error
  ./test-osc94-progress.py warning
"""

import argparse
import sys
import time

ESC = "\x1b"
ST = ESC + "\\"


def osc94(state: int, progress: int = 0) -> str:
    return f"{ESC}]9;4;{state};{progress}{ST}"


def emit(state: int, progress: int = 0) -> None:
    sys.stdout.write(osc94(state, progress))
    sys.stdout.flush()


def set_off() -> None:
    emit(0)


def indefinite(duration: float) -> None:
    print(f"Indeterminate progress for {duration:.0f}s (state 3)...")
    emit(3)
    time.sleep(duration)


def cycle(state: int, step: int, delay: float) -> None:
    label = {1: "normal", 2: "error", 4: "warning"}.get(state, str(state))
    print(f"Cycling 0->100 in '{label}' state ({state})...")
    for pct in range(0, 101, step):
        emit(state, pct)
        sys.stdout.write(f"\r  {pct:3d}%")
        sys.stdout.flush()
        time.sleep(delay)
    print()


def main() -> int:
    p = argparse.ArgumentParser(description="Test OSC 9;4 progress bar sequences.")
    p.add_argument(
        "mode",
        nargs="?",
        default="all",
        choices=["all", "off", "indefinite", "normal", "error", "warning"],
        help="which state to test (default: all)",
    )
    p.add_argument("--step", type=int, default=5, help="percent increment when cycling")
    p.add_argument("--delay", type=float, default=0.1, help="seconds between updates")
    p.add_argument("--hold", type=float, default=3.0, help="seconds to hold indefinite state")
    args = p.parse_args()

    try:
        if args.mode == "off":
            print("Clearing progress (state 0)...")
            set_off()
        elif args.mode == "indefinite":
            indefinite(args.hold)
        elif args.mode == "normal":
            cycle(1, args.step, args.delay)
        elif args.mode == "error":
            cycle(2, args.step, args.delay)
        elif args.mode == "warning":
            cycle(4, args.step, args.delay)
        else:  # all
            indefinite(args.hold)
            cycle(1, args.step, args.delay)
            cycle(4, args.step, args.delay)
            cycle(2, args.step, args.delay)
            print("Done. Clearing progress.")
    finally:
        set_off()

    return 0


if __name__ == "__main__":
    sys.exit(main())
