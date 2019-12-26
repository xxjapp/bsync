require "bsync"

RSpec.describe Bsync do
    it "has a version number" do
        expect(Bsync::VERSION).not_to be nil
    end

    it "lfs: sync file from remote to local" do
        test_root_path      = "/tmp/bsync-test"
        remote_root_path    = "#{test_root_path}/remote"
        local_root_path     = "#{test_root_path}/local"

        remote_file         = "#{remote_root_path}/1.txt"
        local_file          = "#{local_root_path}/1.txt"

        # setup
        FileUtils.rm_rf     test_root_path
        FileUtils.mkdir_p   remote_root_path
        FileUtils.touch     remote_file

        bsync = Bsync::Lfs.new({
            "remote_root_path"  => remote_root_path,
            "local_root_path"   => local_root_path
        })

        FileUtils.rm_f bsync.data_path

        # test
        bsync.synchronize

        # check
        expect(File.file? local_file).to eq(true)
    end
end
