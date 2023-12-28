package main

import (
	"context"
	pb "github.com/jqvk/mestor/backend/gen/grpc"
	"log"
	"net"
	"path/filepath"
	"runtime"

	"google.golang.org/grpc"
)

var counter int32 = 0

type server struct {
	pb.UnimplementedCounterServer
}

// GetTotal implements grpc.CounterServer
func (*server) GetTotal(context.Context, *pb.GetTotalReq) (*pb.TotalRes, error) {
	return &pb.TotalRes{Total: counter}, nil
}

// Increment implements grpc.CounterServer
func (*server) Increment(context.Context, *pb.IncrementByReq) (*pb.TotalRes, error) {
	counter++
	return &pb.TotalRes{Total: counter}, nil
}

func path(rel string) string {
	_, currentFile, _, _ := runtime.Caller(0)
	basepath := filepath.Dir(currentFile)
	return filepath.Join(basepath, rel)
}

func panicErr(err error) {
	if err != nil {
		panic(err)
	}
}

func main() {
  lis, err := net.Listen("tcp", ":50051")
	panicErr(err)
	s := grpc.NewServer()
	server := server{}
	pb.RegisterCounterServer(s, &server)
	log.Printf("server listening at %v\n", lis.Addr())
	if err := s.Serve(lis); err != nil {
		log.Fatalf("failed to serve: %v", err)
	}
}
