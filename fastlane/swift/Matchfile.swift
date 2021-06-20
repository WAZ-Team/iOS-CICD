// Matchfile.swift
// Copyright (c) 2021 FastlaneTools

// This class is automatically included in FastlaneRunner during build

// This autogenerated file will be overwritten or replaced during build time, or when you initialize `match`
//
//  ** NOTE **
//  This file is provided by fastlane and WILL be overwritten in future updates
//  If you want to add extra functionality to this project, create a new file in a
//  new group so that it won't be marked for upgrade
//

public class Matchfile: MatchfileProtocol {
    // If you want to enable `match`, run `fastlane match init`
    // After, this file will be replaced with a custom implementation that contains values you supplied
    // during the `init` process, and you won't see this message
    var username: String {
        return environmentVariable(get: "APPLE_ID")
    }
    
    var teamId: String {
        return environmentVariable(get: "TEAM_ID")
    }
    
    public var gitUrl: String {
        return "https://github.com/WAZ-Team/CertsAndProvisionings.git"
    }
    
    public var gitBranch: String {
        return "master"
    }
    
    public var gitPrivateKey: String? {
        return """
        -----BEGIN OPENSSH PRIVATE KEY-----
        b3BlbnNzaC1rZXktdjEAAAAACmFlczI1Ni1jdHIAAAAGYmNyeXB0AAAAGAAAABBwi3ZlSH
        FMjPhAaCEEBK5WAAAAEAAAAAEAAAAzAAAAC3NzaC1lZDI1NTE5AAAAICPoBW8R0LoxGGxY
        bp4IyKs0PLrTVRD1LGz4F6FtnUVOAAAAoAkwee31ITFBv27nG0kdkHGtXdL6cZB8edg00u
        QYvOXivNtE3Dzz1A06jFZJsN84Vgijz0g1vHKq5Znh9T4b9Ed5zO7KpG2Irwj+QoQheIrZ
        RD4cc1Sx1Iojz/LLdUd7/YihK2s5j/xklfUQdBLbgYh7a5XAfR8wAIt+JmEz/FSLfnL13c
        uPXgjC6ckmvq45dUSrTkdsa0F5PDzlin/xGHc=
        -----END OPENSSH PRIVATE KEY-----
        """
    }
}

// Generated with fastlane 2.182.0
