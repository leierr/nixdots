import app from "ags/gtk4/app"
import { Gdk, Gtk } from "ags/gtk4"
import style from "./style/main.scss"
import topbar from "./widget/topbar"
import Astal from "gi://Astal?version=4.0"
import { execAsync } from "ags/process"
import { monitorFile } from "ags/file"

function createMonitorWindows(monitor: Gdk.Monitor) {
  return [
    topbar(monitor),
  ];
}

(async () => {
  const pathsToMonitor = [`${SRC}/style` ]
  const mainScss = `${SRC}/style/main.scss` // SCSS input file to compile
  const css = `/tmp/style.css` // CSS output file

  let isApplying = false

  async function transpileAndApply() {
    if (isApplying) return
    isApplying = true

    try {
      await execAsync(`sass ${mainScss} ${css}`)
      app.apply_css(css, true)
      print("CSS applied successfully!")
    } catch (error) {
      print("Error transpiling SCSS:", error)
      execAsync(`notify-send -u critical "Error transpiling SCSS" "${error}"`)
    } finally {
      isApplying = false
    }
  }

  pathsToMonitor.forEach((path) => monitorFile(path, transpileAndApply))

  return transpileAndApply()
})()

function main() {
  const windowsByMonitor = new Map<Gdk.Monitor, Gtk.Window[]>();

  const reconcileMonitors = () => {
    const activeMonitors = new Set(app.get_monitors());

    activeMonitors.forEach(monitor => {
      if (!windowsByMonitor.has(monitor))
        windowsByMonitor.set(monitor, createMonitorWindows(monitor));
    });

    for (const [monitor, windows] of windowsByMonitor) {
      if (!activeMonitors.has(monitor)) {
        windows.forEach(w => w.destroy());
        windowsByMonitor.delete(monitor);
      }
    }
  };

  reconcileMonitors();
  app.connect('notify::monitors', reconcileMonitors);
}

app.start({ css: style, main });
