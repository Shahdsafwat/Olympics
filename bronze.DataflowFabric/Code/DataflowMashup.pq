[DefaultOutputDestinationSettings = [DestinationDefinition = [Kind = "Reference", QueryName = "DefaultDestination", IsNewTarget = true], UpdateMethod = [Kind = "Replace"], DestinationTypeSettings = [Kind = "Table"]], StagingDefinition = [Kind = "FastCopy"]]
section Section1;
shared DefaultDestination = Lakehouse.Contents([EnableFolding = false]){[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data]{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data];
[BindToDefaultDestination = true]
shared athlete_events = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "athlete_events", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[BindToDefaultDestination = true]
shared noc_regions = let
  Source = Lakehouse.Contents(null),
  Navigation = Source{[workspaceId = "2c442328-5034-46f0-8872-b9f491b62f96"]}[Data],
  #"Navigation 1" = Navigation{[lakehouseId = "f6c35248-5e95-4630-a2c3-c57913885fa4"]}[Data],
  #"Navigation 2" = #"Navigation 1"{[Id = "noc_regions", ItemKind = "Table"]}[Data]
in
  #"Navigation 2";
[BindToDefaultDestination = true]
shared Merge = let
  Source = Table.NestedJoin(athlete_events, {"NOC"}, noc_regions, {"NOC"}, "noc_regions", JoinKind.LeftOuter),
  #"Expanded noc_regions" = Table.ExpandTableColumn(Source, "noc_regions", {"NOC", "region", "notes"}, {"NOC.1", "region", "notes"}),
  #"Removed columns" = Table.RemoveColumns(#"Expanded noc_regions", {"NOC.1"})
in
  #"Removed columns";
