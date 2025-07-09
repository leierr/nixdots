import app from "ags/gtk4/app"
import { Gdk, Gtk } from "ags/gtk4"
import style from "./style/main.scss"
import topbar from "./widget/topbar"
import Astal from "gi://Astal?version=4.0"
import { execAsync } from "ags/process"
import { monitorFile } from "ags/file"

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

function createMonitorWindows(monitor: Gdk.Monitor) {
  return [
    topbar(monitor),
  ];
}

function main() {
  const windowsPerMonitor = new Map()

  const reconcileMonitors = () => {
    const currentMonitors = app.get_monitors()
    const activeConnectors = new Set()

    currentMonitors.forEach(monitor => {
      const key = monitor.get_connector()
      activeConnectors.add(key)

      if (!windowsPerMonitor.has(key)) {
        windowsPerMonitor.set(key, createMonitorWindows(monitor))
      }
    });

    for (const [key, wins] of windowsPerMonitor) {
      if (!activeConnectors.has(key)) {
        wins.forEach((w: Gtk.Window) => w.destroy())
        windowsPerMonitor.delete(key)
      }
    }
  };

  reconcileMonitors()
  app.connect('notify::monitors', reconcileMonitors)
}

app.start({ css: style, main })
