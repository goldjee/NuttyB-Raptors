---@meta

-- BAR's table extensions (common/tablefunctions.lua) available to tweakdefs

---Deep copy a table.
---@generic T: table
---@param tbl T
---@return T
function table.copy(tbl) end

---Return a new deep merge of two tables; `secondary` wins on conflicts.
---Array parts merge by index, not by value.
---@param primary table
---@param secondary table
---@return table
function table.merge(primary, secondary) end

---Merge `mergeData` into `mergeTarget` and return it.
---@generic T: table
---@param mergeTarget T
---@param mergeData table
---@param deep? boolean
---@return T
function table.mergeInPlace(mergeTarget, mergeData, deep) end

---@param tbl table
---@param item any
---@return boolean
function table.contains(tbl, item) end
