function isRelevant(client) {
  return client.minimizable &&
    (!client.desktops.length || client.desktops.indexOf(workspace.currentDesktop) != -1);
    (!client.activities.length || client.activities.indexOf(workspace.currentActivity.toString()) > -1);
}

function minimizeAllWindows() {
  var allClients = workspace.windowList();
  var relevantClients = [];
  var minimize = false;

  for (var i = 0; i < allClients.length; ++i) {
    if (!isRelevant(allClients[i])) {
        continue;
    }
    if (!allClients[i].minimized) {
        minimize = true;
    }
    relevantClients.push(allClients[i]);
  }

  // Try to preserve last active window by sorting windows.
  relevantClients.sort((a, b) => {
    if (a.active) {
        return 1;
    } else if (b.active) {
        return -1;
    }
    return a.stackingOrder - b.stackingOrder;
  });

  for (var i = 0; i < relevantClients.length; ++i) {
    var wasMinimizedByScript = relevantClients[i].minimizedByScript;
    delete relevantClients[i].minimizedByScript;

    if (minimize) {
      if (relevantClients[i].minimized) {
          continue;
      }
      relevantClients[i].minimized = true;
      relevantClients[i].minimizedByScript = true;
    } else {
      if (!wasMinimizedByScript) {
          continue;
      }
      relevantClients[i].minimized = false;
    }
  }
}

function minimizeSingleWindow(client) {
  client.minimized = true;
  client.minimizedByScript = true;
}

minimizeAllWindows();

workspace.windowActivated.connect(minimizeSingleWindow);
workspace.windowAdded.connect(minimizeSingleWindow);
