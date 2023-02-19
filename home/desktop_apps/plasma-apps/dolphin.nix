{ ... }:
{
  xdg.configFile = {
    dolphinrc = {
      target = "dolphinrc";
      text = ''
        [ContextMenu]
        ShowOpenInNewTab=false

        [Desktop Entry]
        DefaultProfile=Dark.profile

        [General]
        BrowseThroughArchives=true
        ConfirmClosingMultipleTabs=false
        GlobalViewProps=false
        OpenExternallyCalledFolderInNewTab=false
        RememberOpenedTabs=false
        ShowFullPath=true
        ShowToolTips=true
        ShowZoomSlider=false

        [MainWindow][Toolbar mainToolBar]
        IconSize=16
        ToolButtonStyle=IconOnly

        [Notification Messages]
        ConfirmDelete=true
        ConfirmEmptyTrash=true

        [PreviewSettings]
        Plugins=appimagethumbnail,jpegthumbnail,kraorathumbnail,windowsexethumbnail,windowsimagethumbnail,opendocumentthumbnail,gsthumbnail,rawthumbnail,svgthumbnail,cursorthumbnail,imagethumbnail,fontthumbnail,directorythumbnail,comicbookthumbnail,ebookthumbnail,ffmpegthumbs,audiothumbnail

        [Toolbar mainToolBar]
        IconSize=16
        ToolButtonStyle=IconOnly

        [VersionControl]
        enabledPlugins=Git
      '';
    };

    kservicemenurc = {
      target = "kservicemenurc";
      text = ''
        [Show]
        compressfileitemaction=true
        extractfileitemaction=true
        forgetfileitemaction=true
        gdrivecontextmenuaction=true
        installFont=false
        kactivitymanagerd_fileitem_linking_plugin=false
        kdeconnectfileitemaction=true
        kompare=true
        mountisoaction=true
        plasmavaultfileitemaction=true
        runInKonsole=false
        setAsWallpaper=true
        sharefileitemaction=false
        slideshowfileitemaction=false
        tagsfileitemaction=false
      '';
    };
  };

  home.file.dolphin_gui = {
    target = ".local/share/kxmlgui5/dolphin/dolphinui.rc";
    text = ''
      <?xml version='1.0'?>
      <!DOCTYPE gui SYSTEM 'kpartgui.dtd'>
      <gui name="dolphin" version="36">
        <MenuBar>
          <Menu name="file">
            <Action name="new_menu"/>
            <Action name="file_new"/>
            <Action name="new_tab"/>
            <Action name="file_close"/>
            <Action name="undo_close_tab"/>
            <Separator/>
            <Action name="add_to_places"/>
            <Separator/>
            <Action name="renamefile"/>
            <Action name="duplicate"/>
            <Action name="movetotrash"/>
            <Action name="deletefile"/>
            <Separator/>
            <Action name="show_target"/>
            <Separator/>
            <Action name="properties"/>
          </Menu>
          <Menu name="edit">
            <Action name="edit_undo"/>
            <Separator/>
            <Action name="edit_cut"/>
            <Action name="edit_copy"/>
            <Action name="copy_location"/>
            <Action name="edit_paste"/>
            <Separator/>
            <Action name="show_filter_bar"/>
            <Action name="edit_find"/>
            <Separator/>
            <Action name="copy_to_inactive_split_view"/>
            <Action name="move_to_inactive_split_view"/>
            <Action name="edit_select_all"/>
            <Action name="invert_selection"/>
          </Menu>
          <Menu name="view">
            <Action name="view_zoom_in"/>
            <Action name="view_zoom_reset"/>
            <Action name="view_zoom_out"/>
            <Separator/>
            <Action name="sort"/>
            <Action name="view_mode"/>
            <Action name="additional_info"/>
            <Action name="show_preview"/>
            <Action name="show_in_groups"/>
            <Action name="show_hidden_files"/>
            <Separator/>
            <Action name="split_view"/>
            <Action name="split_stash"/>
            <Action name="redisplay"/>
            <Action name="stop"/>
            <Separator/>
            <Action name="panels"/>
            <Menu icon="edit-select-text" name="location_bar">
              <text context="@title:menu">Location Bar</text>
              <Action name="editable_location"/>
              <Action name="replace_location"/>
            </Menu>
            <Separator/>
            <Action name="view_properties"/>
          </Menu>
          <Menu name="go">
            <Action name="bookmarks"/>
            <Action name="closed_tabs"/>
          </Menu>
          <Menu name="tools">
            <Action name="open_preferred_search_tool"/>
            <Action name="open_terminal"/>
            <Action name="open_terminal_here"/>
            <Action name="focus_terminal_panel"/>
            <Action name="compare_files"/>
            <Action name="change_remote_encoding"/>
          </Menu>
        </MenuBar>
        <ToolBar noMerge="1" alreadyVisited="1" name="mainToolBar">
          <text context="@title:menu" translationDomain="dolphin">Main Toolbar</text>
          <Action name="go_back"/>
          <Action name="go_forward"/>
          <Action name="go_up"/>
          <Action name="movetotrash"/>
          <Action name="create_dir"/>
          <Separator name="separator_0"/>
          <Action name="url_navigators"/>
          <Action name="sort"/>
          <Action name="view_mode"/>
          <Separator name="separator_1"/>
          <Separator name="separator_2"/>
          <Action name="open_terminal"/>
          <Action name="hamburger_menu"/>
        </ToolBar>
        <State name="new_file">
          <disable>
            <Action name="edit_undo"/>
            <Action name="edit_redo"/>
            <Action name="edit_cut"/>
            <Action name="edit_copy"/>
            <Action name="renamefile"/>
            <Action name="movetotrash"/>
            <Action name="deletefile"/>
            <Action name="invert_selection"/>
            <Separator/>
            <Action name="go_back"/>
            <Action name="go_forward"/>
          </disable>
        </State>
        <State name="has_selection">
          <enable>
            <Action name="edit_cut"/>
            <Action name="edit_copy"/>
            <Action name="renamefile"/>
            <Action name="duplicate"/>
            <Action name="movetotrash"/>
            <Action name="deletefile"/>
            <Action name="invert_selection"/>
          </enable>
        </State>
        <State name="has_no_selection">
          <disable>
            <Action name="edit_cut"/>
            <Action name="edit_copy"/>
            <Action name="renamefile"/>
            <Action name="duplicate"/>
            <Action name="movetotrash"/>
            <Action name="deletefile"/>
            <Action name="delete_shortcut"/>
            <Action name="invert_selection"/>
          </disable>
        </State>
        <ActionProperties scheme="Default">
          <Action name="compact" priority="0"/>
          <Action name="details" priority="0"/>
          <Action name="edit_copy" priority="0"/>
          <Action name="edit_cut" priority="0" shortcut="Ctrl+X"/>
          <Action name="edit_paste" priority="0"/>
          <Action name="go_back" priority="0"/>
          <Action name="go_forward" priority="0"/>
          <Action name="go_home" priority="0"/>
          <Action name="go_up" priority="0"/>
          <Action name="help_contents" shortcut=""/>
          <Action name="help_whats_this" shortcut=""/>
          <Action name="icons" priority="0"/>
          <Action name="new_tab" shortcut="Ctrl+Shift+N"/>
          <Action name="open_terminal" shortcut="Ctrl+T"/>
          <Action name="stop" priority="0"/>
          <Action name="toggle_filter" priority="0"/>
          <Action name="toggle_search" priority="0"/>
          <Action name="view_zoom_in" priority="0"/>
          <Action name="view_zoom_out" priority="0"/>
          <Action name="view_zoom_reset" priority="0"/>
        </ActionProperties>
      </gui>
    '';
  };
}