require 'serverspec'

# Required by serverspec
set :backend, :exec

describe user("nexus") do
    it { should exist }
    it { should belong_to_group "nexus" }
    # it { have_home_directory "/nexus" } # This doesn't work
end

describe file("/nexus") do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by "nexus" }
    it { should be_grouped_into "nexus" }
end

describe file("/nexus/sonatype-work/nexus/conf/nexus.xml") do
    it { should exist }
    it { should be_file }
    it { should be_owned_by "nexus" }
    it { should be_grouped_into "nexus" }
    it { should contain "<url>https://repo1.maven.org/maven2/</url>" }
    it { should contain "<url>https://repository.apache.org/snapshots/</url>" }
end

describe service("nexus") do
    it { should be_enabled }
    it { should be_running }
end

describe port("8081") do
    it { should be_listening.on("0.0.0.0").with("tcp") }
end
