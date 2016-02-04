module BackupRepos
  module Performers
    class GithubWiki < BaseGit
      def clone_url
        "git@github.com:#{params.full_name}.wiki.git"
      end

      def backup_path
        "#{params.full_name}.wiki.git"
      end
    end
  end
end
