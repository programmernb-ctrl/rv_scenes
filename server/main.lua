local resourceName = GetInvokingResource() or GetCurrentResourceName() or 'rv_scenes'

if not lib.checkDependency(resourceName, '0.0.1') then error("Outdated version for " .. resourceName) end

-- YOUR CODE
