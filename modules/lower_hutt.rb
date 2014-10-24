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
  

  POLL_FOR_READY_WORKFLOW = {
      "instanceId" => "%{instance_id}",
      "status" => "WaitingForExternalActivities",
      "pendingExternalActivities" => [
        {
          "debug" => false,
          "id" => "1.168",
          "displayName" => "Searching ...",
          "typeName" => "Geocortex.Workflow.Activities.ConfigureWorkflowContainer",
          "instanceId" => "%{form_instance_id}",
          "externalId" => "",
          "syncToken" => "",
          "isComplete" => true,
          "isAborted" => false,
          "inputs" => nil,
          "outputs" => []
        }
      ],
      "outputs" => [],
      "workflowData" => nil,
      "instanceData" => "%{instance_data}"
  }

  # 1.166 1.164 1.162 1.159
  EXT_COMMAND = {
      "instanceId" => "%{instance_id}",
      "status" => "WaitingForExternalActivities",
      "pendingExternalActivities" => [
        {
          "debug" => false,
          "id" => "%{command_id}",
          "displayName" => "RunExternalCommand",
          "typeName" => "Geocortex.Workflow.Activities.RunExternalCommand",
          "instanceId" => "%{form_instance_id}",
          "externalId" => "",
          "syncToken" => "",
          "isComplete" => true,
          "isAborted" => false,
          "inputs" => nil,
          "outputs" => []
        }
      ],
      "outputs" => [],
      "workflowData" => nil,
      "instanceData" => "%{instance_data}"
  }

  ADDRESS_SEARCH_WORKFLOW = {
      "instanceId" => "%{instance_id}",
      "status" => "WaitingForExternalActivities",
      "pendingExternalActivities" => [
        {
          "debug" => false, 
          "id" => "1.106", 
          "displayName" => "Search Form", 
          "typeName" => "Geocortex.Workflow.Activities.DisplayForm",
          "instanceId" => "%{form_instance_id}",
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
      "instanceData" => "%{instance_data}"
  }

  GET_RESULTS_WORKFLOW = {
      "instanceId" => "%{instance_id}",
      "status" => "WaitingForExternalActivities",
      "pendingExternalActivities" => [
        {
          "debug" => false,
          "id" => "1.115",
          "displayName" => "Searching ...",
          "typeName" => "Geocortex.Workflow.Activities.ConfigureWorkflowContainer",
          "instanceId" => "%{form_instance_id}",
          "externalId" => "",
          "syncToken" => "",
          "isComplete" => true,
          "isAborted" => false,
          "inputs" => nil,
          "outputs" => []
        }
      ],
      "outputs" => [],
      "workflowData" => nil,
      "instanceData" => "%{instance_data}"
  }
  

  def matches(address)
    return true
  end

  def get_info(address)
    requester = Requester.new(URL)
    requester.initial_request INITIAL_DATA

    requester.request POLL_FOR_READY_WORKFLOW
    requester.request EXT_COMMAND, command_id: '1.166'
    requester.request EXT_COMMAND, command_id: '1.164'
    requester.request EXT_COMMAND, command_id: '1.162'
    requester.request EXT_COMMAND, command_id: '1.159'
    requester.request ADDRESS_SEARCH_WORKFLOW
    response = requester.request GET_RESULTS_WORKFLOW

    response

  end


end

class Requester
  @context = {}

  def initialize(url)
    @url = url
  end

  def initial_request(initial_data)
    response = JSON.parse(HTTParty.post(@url, body: initial_data).body)
    @context = {
      instance_id: response['instanceId'],
      form_instance_id: response['pendingExternalActivities'][0]['instanceId'],
      instance_data: response['instanceData']
    }
  end

  def request(workflow_data, params = {})
    request_data = {f: 'json'}
    request_data['workflow'] = workflow_data.to_json % @context.merge(params)
    response = JSON.parse(HTTParty.post(@url, body: request_data).body)
    @context = {
      instance_id: response['instanceId'],
      form_instance_id: response['pendingExternalActivities'][0]['instanceId'],
      instance_data: response['instanceData']
    }
    response
  end

end