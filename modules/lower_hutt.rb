class Modules::LowerHutt

  URL = 'http://gisweb.huttcity.govt.nz/Geocortex/Essentials/Essentials_4.1.2/REST/sites/HCC/workflows/New_Address_Search/run'
  INITIAL_DATA = {
    f: 'json',
    inargs: [
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_formDescription","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_autoTooltip","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_autoLabel","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_formTitle","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_selectLayerID","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_selectMapServiceID","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_queryServiceURL","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_autoSearchClause","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil},
      {"runtimeTypeName" => "System.String, mscorlib","name" => "_searchField","typeName" => "System.String, mscorlib","isRequired" => false,"value" => nil}
    ].to_json
  }
  
  REQUEST = {
    f: 'json',
    workflow: {
      "instanceId" => "4bb0a6de-3838-4821-8bcc-2b4bd179d534",
      "status" => "WaitingForExternalActivities",
      "pendingExternalActivities" => [
        {
          "debug" => false, 
          "id" => "1.106", 
          "displayName" => "Search Form", 
          "typeName" => "Geocortex.Workflow.Activities.DisplayForm",
          "instanceId" => "86824bbf-a8a2-4bb5-a066-1029a51cddc6",
          "externalId" => "",
          "syncToken" => "",
          "isComplete" => true,
          "isAborted" => false,
          "inputs" => nil,
          "outputs" => [
            {
              "runtimeTypeName" => "System.String",
              "name" => "ArgAddress",
              "typeName" => "System.String, mscorlib",
              "isRequired" => false,
              "value" => "15 Miromiro Road NORMANDALE"
            },
            {
              "runtimeTypeName" => "System.String",
              "name" => "ButtonResultValue",
              "typeName" => "System.String, mscorlib",
              "isRequired" => false,
              "value" => "True"
            },
            {
              "runtimeTypeName" => "System.Collections.Generic.Dictionary`2[[System.String, mscorlib],[System.Object, mscorlib]], mscorlib",
              "name" => "FormResults",
              "typeName" => "System.Collections.Generic.Dictionary`2[[System.String, mscorlib],[System.Object, mscorlib]], mscorlib",
              "isRequired" => false,
              "value" => nil
            }
          ]
        }
      ],
      "outputs" => [],
      "workflowData" => nil,
      "instanceData" => "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"
    }
  }

  def matches(address)
    return true
  end

  def get_info(address)
    response = JSON.parse(HTTParty.post(URL, query: INITIAL_DATA).body)
    instance_id = response['instanceId']
    instance_data = response['instanceData']
    
    pp response
  end

end
