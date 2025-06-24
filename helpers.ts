import { Gdk } from "astal/gtk3"

export function getMonitorName(gdkmonitor: Gdk.Monitor): string {
  const display = Gdk.Display.get_default() as Gdk.Display
  const screen = display.get_default_screen()

  for (let i = 0; i < display.get_n_monitors(); ++i) {
    if (gdkmonitor === display.get_monitor(i))
      return screen.get_monitor_plug_name(i) ?? "";
  }

  return "";
}

