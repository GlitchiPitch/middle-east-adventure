local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Shared = require(ReplicatedStorage.Shared)

local Infrastructure = require(script.Infrastructure)
local Application = require(script.Application)

---@class Server
---@field shared Shared
---@field diContainer DIContainer
---@field application ServerApplication
---@field infrastructure ServerInfrastructure
local Server = {}
Server.__index = Server

---@return Server
function Server.new()
    local self = setmetatable({}, Server)
    self.shared = Shared.new()
    self.diContainer = self.shared.diContainer
    self.application = Application.new()
    self.infrastructure = Infrastructure.new()
    return self
end

function Server:init()
    self.diContainer:singleton("Shared", function()
        return self.shared
    end)

    self.diContainer:singleton("Domain", function()
        return self.shared.domain
    end)

    self.diContainer:singleton("Infrastructure", function()
        return self.infrastructure
    end)

    self.diContainer:singleton("Application", function()
        return self.application
    end)

    self.application:init()

    ReplicatedStorage:SetAttribute(self.shared.constants.INIT_SERVER, true)
end

local server = Server.new()
server:init()
