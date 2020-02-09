import LightningKit

struct Configuration {
    static let defaultRpcCredentials = RpcCredentials(
        host: "localhost",
        port: 10009,
        certificate: """
-----BEGIN CERTIFICATE-----
MIICgDCCAiagAwIBAgIQJIoAqJ7+VlIEhGDvXJYxwTAKBggqhkjOPQQDAjBJMR8w
HQYDVQQKExZsbmQgYXV0b2dlbmVyYXRlZCBjZXJ0MSYwJAYDVQQDEx1Fc2VuYmVr
cy1NYWNCb29rLVByby1pNy5sb2NhbDAeFw0yMDAxMjEwNTIzMTlaFw0yMTAzMTcw
NTIzMTlaMEkxHzAdBgNVBAoTFmxuZCBhdXRvZ2VuZXJhdGVkIGNlcnQxJjAkBgNV
BAMTHUVzZW5iZWtzLU1hY0Jvb2stUHJvLWk3LmxvY2FsMFkwEwYHKoZIzj0CAQYI
KoZIzj0DAQcDQgAEWF+bLu2uBUcJeWiHmQ9RJ9EaNUMiKOb7z9VndePs5dydGFZv
0lX1VbfsaOpyrlOdlZcdIL0/hqMutHAoUlhfoKOB7zCB7DAOBgNVHQ8BAf8EBAMC
AqQwDwYDVR0TAQH/BAUwAwEB/zCByAYDVR0RBIHAMIG9gh1Fc2VuYmVrcy1NYWNC
b29rLVByby1pNy5sb2NhbIIJbG9jYWxob3N0ggR1bml4ggp1bml4cGFja2V0ggdi
dWZjb25uhwR/AAABhxAAAAAAAAAAAAAAAAAAAAABhxD+gAAAAAAAAAAAAAAAAAAB
hxD+gAAAAAAAAAQ2NH/9JUkfhwTAqAQWhxD+gAAAAAAAAGDgDP/+0yIdhxD+gAAA
AAAAALntMem5RM5khxD+gAAAAAAAAK7eSP/+ABEiMAoGCCqGSM49BAMCA0gAMEUC
IQC+9DLaZqNUWDF0KLQDGF1KPCLd4MFD+XxHssj0DUHt1wIgclsIHiR3hUtrPFLi
ZfD6wdSSgNsNh1iIHbxXbdVjGYU=
-----END CERTIFICATE-----
""",
        macaroon: "0201036C6E6402EB01030A10DF2F1EA29964D32ED377D7F5E188CABB1201301A160A0761646472657373120472656164120577726974651A130A04696E666F120472656164120577726974651A170A08696E766F69636573120472656164120577726974651A140A086D616361726F6F6E120867656E65726174651A160A076D657373616765120472656164120577726974651A170A086F6666636861696E120472656164120577726974651A160A076F6E636861696E120472656164120577726974651A140A057065657273120472656164120577726974651A180A067369676E6572120867656E657261746512047265616400000620C7CFE79C930DDDDE2995CBC207D768657A663D7D04F6B1EF548C23D35C9DD30E"
    )
}
