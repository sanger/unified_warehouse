# DBAs requested to adjust table definition in the MLWH database so that the upgrade to MySQL v8.4
# can proceed smoothly. See Y26-207
class AlterOSeqFlowcellRowFormat < ActiveRecord::Migration[7.2]
  def up
    ActiveRecord::Base.connection.execute("ALTER TABLE `oseq_flowcell` ROW_FORMAT=DYNAMIC;")
  end
end
