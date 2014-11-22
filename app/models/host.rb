class Host
  include LiveStatus
  extend LiveStatus::ClassMethods
  attr_accessor :id, :name, :address, :state, :worst_service_state, :name_alias,
    :checks_enabled, :last_check, :next_check, :downtimes_with_info, :groups,
    :check_period, :num_services, :last_state_change, :last_time_down,
    :last_time_unreachable, :latency, :perf_data, :long_plugin_output,
    :services, :services_with_info, :services_with_state

  def initialize args
    args.each do |k,v|
      if k == :services_with_info
        instance_variable_set("@services", v.map {|s| Hash[name: s[0], state: s[1], has_been_checked: s[2], detail: s[3]] })
      else
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end
  end

  def self.all
    get_hosts(Columns: 'id name address state worst_service_state',
              Sort: 'state DESC').map {|h| self.new(id: h['id'],
                                                    name: h['name'],
                                                    address: h['address'],
                                                    state: h['state'],
                                                    worst_service_state: h['worst_service_state']
                                                    ) }
  end

  def self.find(id)
    result = get_host(id, {Sort: 'name ASC'})
    if result
      self.new(id: result['id'],
               name: result['name'],
               address: result['address'],
               state: result['state'],
               worst_service_state: result['worst_service_state'],
               name_alias: result['alias'],
               checks_enabled: result['checks_enabled'],
               last_check: result['last_check'],
               next_check: result['next_check'],
               downtimes_with_info: result['downtimes_with_info'],
               groups: result['groups'],
               check_period: result['check_period'],
               num_services: result['num_services'],
               last_state_change: result['last_state_change'],
               last_time_down: result['last_time_down'],
               last_time_unreachable: result['last_time_unreachable'],
               latency: result['latency'],
               perf_data: result['perf_data'],
               long_plugin_output: result['long_plugin_output'],
               services_with_info: result['services_with_info'],
              )
    end
  end

end
