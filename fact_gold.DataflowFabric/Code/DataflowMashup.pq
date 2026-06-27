[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
[BindToDefaultDestination = true]
shared AllData = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "AllData", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared event = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "event", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared gam = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "gam", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared gender = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "gender", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared medal = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "medal", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared name = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "name", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared NOC = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "NOC", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared team = let
  Source = Lakehouse.Contents([HierarchicalNavigation = null, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "team", ItemKind = "Table"]}[Data]
in
  #"Navigation 3";
[BindToDefaultDestination = true]
shared Merge = let
  Source = Table.NestedJoin(AllData, {"Name"}, name, {"Name"}, "name (2)", JoinKind.LeftOuter)
in
  Source;
[DataDestinations = {[Definition = [Kind = "Reference", QueryName = "Merge (2)_DataDestination", IsNewTarget = true], Settings = [Kind = "Automatic", TypeSettings = [Kind = "Table"]]]}]
shared #"Merge (2)" = let
  Source = Table.NestedJoin(Merge, {"Sex"}, gender, {"Sex"}, "gender", JoinKind.LeftOuter),
  #"Expanded gender" = Table.ExpandTableColumn(Source, "gender", {"gen_id", "gender", "Sex"}, {"gen_id", "gender.1", "Sex.1"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded gender", {"Sex.1", "gender.1"}),
  #"Expanded name (2)" = Table.ExpandTableColumn(#"Removed columns", "name (2)", {"name_id", "Name"}, {"name_id", "Name.1"}),
  #"Removed columns 1" = Table.RemoveColumns(#"Expanded name (2)", {"Name.1"})
in
  #"Removed columns 1";
[BindToDefaultDestination = true]
shared #"Merge (3)" = let
  Source = Table.NestedJoin(#"Merge (2)", {"Team"}, team, {"Team"}, "team (2)", JoinKind.LeftOuter),
  #"Expanded team (2)" = Table.ExpandTableColumn(Source, "team (2)", {"team_id", "Team"}, {"team_id", "Team.1"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded team (2)", {"Team.1"})
in
  #"Removed columns";
[BindToDefaultDestination = true]
shared #"Merge (4)" = let
  Source = Table.NestedJoin(#"Merge (3)", {"NOC"}, NOC, {"NOC"}, "NOC (2)", JoinKind.LeftOuter),
  #"Expanded NOC (2)" = Table.ExpandTableColumn(Source, "NOC (2)", {"NOC", "region", "NOC_id"}, {"NOC.1", "region.1", "NOC_id"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded NOC (2)", {"NOC.1", "region.1"})
in
  #"Removed columns";
[BindToDefaultDestination = true]
shared #"Merge (5)" = let
  Source = Table.NestedJoin(#"Merge (4)", {"Games"}, gam, {"Games"}, "gam", JoinKind.LeftOuter),
  #"Expanded gam" = Table.ExpandTableColumn(Source, "gam", {"gam_id", "Year", "Season", "City", "Games"}, {"gam_id", "Year.1", "Season.1", "City.1", "Games.1"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded gam", {"Games.1", "City.1", "Season.1", "Year.1"})
in
  #"Removed columns";
[BindToDefaultDestination = true]
shared #"Merge (6)" = let
  Source = Table.NestedJoin(#"Merge (5)", {"Event"}, event, {"Event"}, "event (2)", JoinKind.LeftOuter),
  #"Expanded event (2)" = Table.ExpandTableColumn(Source, "event (2)", {"event_id", "Event", "Sport"}, {"event_id", "Event.1", "Sport.1"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded event (2)", {"Event.1", "Sport.1"})
in
  #"Removed columns";
[BindToDefaultDestination = true]
shared #"Merge (7)" = let
  Source = Table.NestedJoin(#"Merge (6)", {"Medal"}, medal, {"Medal"}, "medal (2)", JoinKind.LeftOuter),
  #"Expanded medal (2)" = Table.ExpandTableColumn(Source, "medal (2)", {"medal_id", "Medal", "Custom"}, {"medal_id", "Medal.1", "Custom"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded medal (2)", {"Custom", "Medal.1", "notes", "region", "Medal", "Event", "Sport", "City", "Season", "Year", "Games", "NOC", "Team", "Sex", "Name"}),
  #"Replaced value" = Table.ReplaceValue(#"Removed columns", "NA", null, Replacer.ReplaceValue, {"Age"}),
  #"Replaced value 1" = Table.ReplaceValue(#"Replaced value", "NA", null, Replacer.ReplaceValue, {"Height"}),
  #"Replaced value 2" = Table.ReplaceValue(#"Replaced value 1", "NA", null, Replacer.ReplaceValue, {"Weight"}),
  #"Changed column type" = Table.TransformColumnTypes(#"Replaced value 2", {{"Height", type number}, {"Age", Int64.Type}, {"Weight", type number}})
in
  #"Changed column type";
[BindToDefaultDestination = true]
shared #"fact table" = let
  Source = #"Merge (7)",
  #"Removed columns" = Table.RemoveColumns(Source, {"ID"}),
  #"Added index" = Table.AddIndexColumn(#"Removed columns", "Index", 1, 1, Int64.Type),
  #"Reordered columns" = Table.ReorderColumns(#"Added index", {"Index", "Age", "Height", "Weight", "name_id", "gen_id", "team_id", "NOC_id", "gam_id", "event_id", "medal_id"}),
  #"Renamed columns" = Table.RenameColumns(#"Reordered columns", {{"Index", "fact_id"}})
in
  #"Renamed columns";
shared #"Merge (2)_DataDestination" = let
  Pattern = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  Navigation_1 = Pattern{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  Navigation_2 = Navigation_1{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  Navigation_3 = Navigation_2{[Id = "dbo", ItemKind = "Schema"]}[Data],
  TableNavigation = Navigation_3{[Id = "Merge _2_", ItemKind = "Table"]}?[Data]?
in
  TableNavigation;
shared DefaultDestination = let
  Source = Lakehouse.Contents([CreateNavigationProperties = false, EnableFolding = false, HierarchicalNavigation = true, EnableVorder = true, OutputMetadataRefresh = true]),
  #"Navigation 1" = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 3" = #"Navigation 2"{[Id = "dbo", ItemKind = "Schema"]}[Data]
in
  #"Navigation 3";
