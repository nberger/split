require 'spec_helper'

describe Split::Configuration do

  before(:each) { @config = Split::Configuration.new }

  it "should provide a default value for ignore_ip_addresses" do
    @config.ignore_ip_addresses.should eql([])
  end

  it "should provide default values for db failover" do
    @config.db_failover.should be_false
    @config.db_failover_on_db_error.should be_a Proc
  end

  it "should not allow multiple experiments by default" do
    @config.allow_multiple_experiments.should be_false
  end

  it "should be enabled by default" do
    @config.enabled.should be_true
  end

  it "disabled is the opposite of enabled" do
    @config.enabled = false
    @config.disabled?.should be_true
  end

  it "should provide a default pattern for robots" do
    %w[Baidu Gigabot Googlebot libwww-perl lwp-trivial msnbot SiteUptime Slurp WordPress ZIBB ZyBorg].each do |robot|
      @config.robot_regex.should =~ robot
    end
  end

  it "should use the session adapter for persistence by default" do
    @config.persistence.should eq(Split::Persistence::SessionAdapter)
  end

  it "should load a metric" do
    @config.experiments = {:my_experiment=>
        {:variants=>["control_opt", "other_opt"], :metric=>:my_metric}}

    @config.metrics.should_not be_nil
    @config.metrics.keys.should ==  [:my_metric]
  end
end