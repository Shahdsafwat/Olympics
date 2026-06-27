[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared OBT = let
  Source = Fabric.Warehouse([HierarchicalNavigation = null]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[warehouseId = "34be41d4-eab3-4526-890a-e7bf095eecc6"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Schema = "dbo", Item = "OBT"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared gender = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"Sex"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"Sex"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Added index", "gender", each if [Sex] = "M" then "Male"
else if [Sex] = "F" then "Female"
else [Sex]), {{"gender", type text}}),
  #"Reordered columns" = Table.ReorderColumns(#"Added custom", {"Index", "gender", "Sex"}),
  #"Renamed columns" = Table.RenameColumns(#"Reordered columns", {{"Index", "gen_id"}})
in
  #"Renamed columns";
[BindToDefaultDestination = true]
shared event = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"Event", "Sport"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"Event"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Reordered columns" = Table.ReorderColumns(#"Added index", {"Index", "Event", "Sport"}),
  #"Renamed columns" = Table.RenameColumns(#"Reordered columns", {{"Index", "event_id"}})
in
  #"Renamed columns";
[BindToDefaultDestination = true]
shared medal = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"Medal"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"Medal"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Reordered columns" = Table.ReorderColumns(#"Added index", {"Index", "Medal"}),
  #"Added custom" = Table.TransformColumnTypes(Table.AddColumn(#"Reordered columns", "Custom", each if [Medal] = "Gold" then "1st"
else if [Medal] = "Silver" then "2nd"
else if [Medal] = "Bronze" then "3rd"
else if [Medal] = "Loser" then "Lost"
else "unkown"), {{"Custom", type text}}),
  #"Renamed columns" = Table.RenameColumns(#"Added custom", {{"Index", "medal_id"}})
in
  #"Renamed columns";
[BindToDefaultDestination = true]
shared team = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"Team"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"Team"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Renamed columns" = Table.RenameColumns(#"Added index", {{"Index", "id"}}),
  #"Reordered columns" = Table.ReorderColumns(#"Renamed columns", {"id", "Team"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Reordered columns", {{"id", "team_id"}})
in
  #"Renamed columns 1";
[BindToDefaultDestination = true]
shared name = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"Name"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"Name"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Renamed columns" = Table.RenameColumns(#"Added index", {{"Index", "name_id"}}),
  #"Reordered columns" = Table.ReorderColumns(#"Renamed columns", {"name_id", "Name"})
in
  #"Reordered columns";
[BindToDefaultDestination = true]
shared gam = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"Year", "Season", "City", "Games"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"Year"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Renamed columns" = Table.RenameColumns(#"Added index", {{"Index", "name_id"}}),
  #"Reordered columns" = Table.ReorderColumns(#"Renamed columns", {"name_id", "Year", "Season", "City", "Games"}),
  #"Renamed columns 1" = Table.RenameColumns(#"Reordered columns", {{"name_id", "gam_id"}})
in
  #"Renamed columns 1";
[BindToDefaultDestination = true]
shared NOC = let
  Source = OBT,
  #"Removed other columns" = Table.SelectColumns(Source, {"NOC", "region"}),
  #"Removed duplicates" = Table.Distinct(#"Removed other columns", {"NOC"}),
  #"Added index" = Table.AddIndexColumn(#"Removed duplicates", "Index", 1, 1, Int64.Type),
  #"Renamed columns" = Table.RenameColumns(#"Added index", {{"Index", "NOC_id"}})
in
  #"Renamed columns";
shared DefaultDestination = let
  Source = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "dbo", ItemKind = "Schema"]}[Data]
in
  #"Navigation 3";
