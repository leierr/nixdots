import { Astal, Gtk, Gdk } from "astal/gtk3"
import { getMonitorName } from "../helpers"
import { GLib, Gio, Variable, bind, timeout } from "astal"
import Hyprland from "gi://AstalHyprland"
import Tray from "gi://AstalTray"
const hyprland = Hyprland.get_default()

const DistroLogo = () => (
  <button className="distroLogo" >
    <icon icon={GLib.get_os_info("LOGO") || "missing-symbolic"} />
  </button>
)

function Workspaces({ hyprlandMonitor }: { hyprlandMonitor: Hyprland.Monitor }) {
  return (
    <box className={"workspaces"}>
      { bind(hyprland, "workspaces").as(ws => ws
        .filter(wss => wss.monitor === hyprlandMonitor && !(wss.id >= -99 && wss.id <= -2))
        .sort((a, b) => a.id - b.id)
        .map((wss, idx) =>
          <button
            className={bind(Variable.derive([bind(hyprland, "focusedWorkspace"),bind(wss, "clients")]))
              .as( ([fws, clients]) => `${fws === wss ? "focused " : ""}${clients.length > 0 ? "occupied" : ""}`
            )}
            cursor={'pointer'}
            onClicked={() => wss.focus?.()}>
            {idx + 1}
          </button>
        ))
      }
    </box>
  )
}

const dateTime = Variable<string>("").poll(5000, () => GLib.DateTime.new_now_local().format("%a %e %B ‧ %H:%M")!
  .replace(/\b\w/g, c => c.toUpperCase()) // Capitalize first letter of the month
  .replace(/\./g, '') // Remove the period from date
  .replace(/^\s+|\s+$/g, '') // Remove excessive spaces.
)
const DateTime = () => (
  <button className="datetime" cursor={'pointer'} >
    <label label={dateTime()} />
  </button>
)

function SysTray() {
  const tray = Tray.get_default()

  function createMenu(menuModel: Gio.MenuModel, actionGroup: Gio.ActionGroup): Gtk.Menu {
    const menu: Gtk.Menu = Gtk.Menu.new_from_model(menuModel);
    menu.insert_action_group("dbusmenu", actionGroup);
    return menu;
  }


  return (
    <box className="systray">
      {bind(tray, "items").as(items => items.map(item => {
        let menu: Gtk.Menu = createMenu(item.menu_model, item.action_group);
        return (
          <button
            className="systrayitem"
            halign={Gtk.Align.CENTER}
            valign={Gtk.Align.CENTER}
            tooltip_markup={bind(item, "tooltip_markup")}
            onClick={(btn, event) => {
              if (event.button === Gdk.BUTTON_SECONDARY) {
                menu?.popup_at_widget(btn, Gdk.Gravity.SOUTH_EAST, Gdk.Gravity.NORTH_EAST, null);
              }
            }}>
            <icon gicon={bind(item, "gicon")}/>
          </button>
        )}))}
    </box>
  )
}

export default function( gdkmonitor: Gdk.Monitor ) {
  let hyprlandMonitor = hyprland.monitors.find(m => m.name === getMonitorName(gdkmonitor)) as Hyprland.Monitor;

  return <window
    className="topbar"
    gdkmonitor={gdkmonitor}
    exclusivity={Astal.Exclusivity.EXCLUSIVE}
    anchor={Astal.WindowAnchor.TOP | Astal.WindowAnchor.LEFT | Astal.WindowAnchor.RIGHT}>
    <revealer
      setup={self=>timeout(500, () => self.revealChild=true)}
      transitionType={Gtk.RevealerTransitionType.SLIDE_DOWN}
      transitionDuration={1000}>
      <centerbox className={"centerbox"}>
        <box hexpand halign={Gtk.Align.START}>
          <DistroLogo/>
          <Workspaces hyprlandMonitor={hyprlandMonitor} />
        </box>
        <box>
          <DateTime/>
        </box>
        <box hexpand halign={Gtk.Align.END}>
          <SysTray/>
        </box>
      </centerbox>
    </revealer>
  </window>
}
