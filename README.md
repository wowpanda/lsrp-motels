# lsrp-motels

Thank you for downloading my LosSantosRP Motels Script, this will enable users to purchase a motel lot from any motels you specify in the Config file.

All locations and rooms are configured in the Config.lua file, please ensure you keep the "format" how it is currently, 
should be pretty easy to know how to add a extra motel, 
simply copy the format of the Pink Cage Motel already entered.

### Requirements
------------
The following dependencys are required for this script to operate successfully without issues. please ensure you have them started in your resources and working correctly before hand.

- [instance](https://github.com/ESX-Org/instance)
- [cron](https://github.com/ESX-Org/cron)
- [esx_addonaccount](https://github.com/ESX-Org/esx_addonaccount)
- [esx_addoninventory](https://github.com/ESX-Org/esx_addoninventory)
- [esx_datastore](https://github.com/ESX-Org/esx_datastore)
- [esx_inventoryhud 2.3+](https://github.com/Trsak/esx_inventoryhud)
- [mythic_progbar](https://github.com/mythicrp/progressbar)
- [esx_kashacters](https://github.com/XxFri3ndlyxX/kashacters) - Optional Please ensure you have added XxFri3ndlyxX's Switch Character fix aswell.

### Features
------------

- Motel Room Storage
- Motel Room Bed Stash
- Change / Load Saved Outfits
- Configuarition of Multiple Motels & Rooms
- Configurable Options
- Instanced
- Instanced Voice

### Intergrating Inventorys Tutorial

To enable the inventory hud to work correctly with Motels you will need to add the files from the IHUD folder to the Inventory Hud
and move them to the following folder

"esx_inventoryhud/client"

Secondly we need to load these files from the Inventory Hud resource within esx_inventoryhud open the __resource.lua file and add the following lines in the client_scripts section

```
"client/motels.lua",
"client/beds.lua",
```

The end result would look something similar to

```
client_scripts {
  "@es_extended/locale.lua",
  "client/main.lua",
  "client/trunk.lua",
  "client/property.lua",
  "client/motels.lua",
  "client/beds.lua",
  "client/player.lua",
  "locales/cs.lua",
  "locales/en.lua",
  "locales/fr.lua",
  "config.lua"
}
```

We now need to adjust the Javascript files for inventory hud, to allow the loading of the Inventorys successfully
Open esx_inventoryhud/html/js/inventory.js

### Search for

```
if (type === "normal") {
            $(".info-div").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
        } else if (type === "property") {
            $(".info-div").hide();
        } else if (type === "player") {
            $(".info-div").show();
        }
```

### And replace with

```
if (type === "normal") {
            $(".info-div").hide();
        } else if (type === "trunk") {
            $(".info-div").show();
        } else if (type === "property") {
            $(".info-div").hide();
        } else if (type === "motels") {
            $(".info-div").hide();
        } else if (type === "motelsbed") {
            $(".info-div").hide();
        } else if (type === "player") {
            $(".info-div").show();
        }
```

### Then further down the file search for the following

```
$('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));

            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

### and replace with

```
$('#playerInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "motels" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromMotel", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "motelsbed" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromMotelBed", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "second") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/TakeFromPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

### A few more lines down search for

```
$('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

### And replace with

```
$('#otherInventory').droppable({
        drop: function (event, ui) {
            itemData = ui.draggable.data("item");
            itemInventory = ui.draggable.data("inventory");

            if (type === "trunk" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoTrunk", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "property" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoProperty", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "motels" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoMotel", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "motelsbed" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoMotelBed", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            } else if (type === "player" && itemInventory === "main") {
                disableInventory(500);
                $.post("http://esx_inventoryhud/PutIntoPlayer", JSON.stringify({
                    item: itemData,
                    number: parseInt($("#count").val())
                }));
            }
        }
    });
```

Ensure that you run the SQL File provided which adds the correct Motels Table, and also enables the correct datastores to be created

In your server.cfg file 

```
start lsrp-motels
```

And restart your server, you should then be able to use the resource, if any problems arise please raise a request in the github,

### PLEASE NOTE THIS IS A BETA RELEASE AT PRESENT