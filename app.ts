import { App, Gdk, Gtk } from "astal/gtk3"
import { execAsync, monitorFile } from "astal";
import topbar from "./widget/topbar"
import style from "./style/main.scss"

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
      App.apply_css(css, true)
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

function initMonitorWidgets (monitor: Gdk.Monitor): Gtk.Widget[] {
  return [
    topbar(monitor),
  ]
}

function main() {
  // Map each monitor to the array of widgets it owns
  const monitorWidgets = new Map<Gdk.Monitor, Gtk.Widget[]>()
  for (const monitor of App.get_monitors()) {
    monitorWidgets.set(monitor, initMonitorWidgets(monitor))
  }

  // When a monitor is added, create its widgets and store them
  App.connect("monitor-added", (monitor: Gdk.Monitor) => {
    monitorWidgets.set(monitor, initMonitorWidgets(monitor))
  })

  // When a monitor is removed, destroy its widgets and forget them
  App.connect("monitor-removed", (monitor: Gdk.Monitor) => {
    monitorWidgets.get(monitor)?.forEach(w => w.destroy())
    monitorWidgets.delete(monitor)
  })
}

App.start({ css: style, main })
