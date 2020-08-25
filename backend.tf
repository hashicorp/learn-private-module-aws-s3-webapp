terraform {
    backend "remote"{
        organization = "personal-jmo"
token = "mnoH5skQPy6JtQ.atlasv1.31QeMKSfTjioptki4rZVR2MDogAr60GKiaCCy828DvSUEadkBz9rlrhck6mhuFYem8s"
        workspaces {
            name = "learn-private-module-aws-s3-webapp"
        }


    }
}


