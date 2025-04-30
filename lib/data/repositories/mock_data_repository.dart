
import '../../core/theme/app_colors.dart';
import '../../domain/entities/artist.dart';
import '../../domain/entities/genre.dart';
import '../../domain/entities/playlist.dart';
import '../../domain/entities/track.dart';

class MockDataRepository {
  // Mock tracks
  List<Track> get popularTracks => [
        const Track(
          id: '1',
          title: 'As It Was',
          artist: 'Harry Styles',
          album: 'Harry\'s House',
          albumArt: 'https://i.scdn.co/image/ab67616d0000b273b46f74097655d7f353caab14',
          durationInSeconds: 167,
          isLiked: true,
          playbackPercentage: 0.67,
        ),
        const Track(
          id: '2',
          title: 'Blinding Lights',
          artist: 'The Weeknd',
          album: 'After Hours',
          albumArt: 'https://i.scdn.co/image/ab67616d0000b273c8b444df094279e70d0ed856',
          durationInSeconds: 203,
          isLiked: false,
        ),
        const Track(
          id: '3',
          title: 'Bad Habit',
          artist: 'Steve Lacy',
          album: 'Gemini Rights',
          albumArt: 'https://i.scdn.co/image/ab67616d0000b273c6b577e4c4a6d326354a89f7',
          durationInSeconds: 232,
          isLiked: true,
        ),
        const Track(
          id: '4',
          title: 'Heat Waves',
          artist: 'Glass Animals',
          album: 'Dreamland',
          albumArt: 'https://i.scdn.co/image/ab67616d0000b27389fd6d8d400f372bea571999',
          durationInSeconds: 238,
          isLiked: false,
          playbackPercentage: 0.22,
        ),
        const Track(
          id: '5',
          title: 'Running Up That Hill',
          artist: 'Kate Bush',
          album: 'Hounds of Love',
          albumArt: 'https://i.scdn.co/image/ab67616d0000b273a85af0950aa5e9e7d978e73c',
          durationInSeconds: 298,
          isLiked: true,
        ),
        const Track(
          id: '6',
          title: 'I Ain\'t Worried',
          artist: 'OneRepublic',
          album: 'Top Gun: Maverick',
          albumArt: 'https://i.scdn.co/image/ab67616d0000b273ec96e006b8bdfc582610ec13',
          durationInSeconds: 148,
          isLiked: false,
        ),
      ];

  // Mock playlists
  List<Playlist> get recommendedPlaylists => [
        Playlist(
          id: '1',
          name: 'Daily Mix 1',
          description: 'Harry Styles, The Weeknd, Glass Animals and more',
          coverImageUrl: 'https://dailymix-images.scdn.co/v2/img/ab6761610000e5ebfe3adb90a10256c3928ed922/1/en/default',
          createdBy: 'Spotify',
          tracks: popularTracks.take(4).toList(),
          isPersonalized: true,
        ),
        Playlist(
          id: '2',
          name: 'Discover Weekly',
          description: 'Your weekly mixtape of fresh music',
          coverImageUrl: 'https://i.scdn.co/image/ab67706f000000025551996f500ba876bda73fa5',
          createdBy: 'Spotify',
          tracks: popularTracks.skip(2).take(4).toList(),
          isPersonalized: true,
        ),
        Playlist(
          id: '3',
          name: 'Chill Mix',
          description: 'Kick back to some laid-back tunes',
          coverImageUrl: 'https://seed-mix-image.spotifycdn.com/v6/img/chill/2o8lFaSoSkCCXUBfL7grRk/en/default',
          createdBy: 'Spotify',
          tracks: popularTracks.skip(1).take(3).toList(),
          isPersonalized: true,
        ),
        Playlist(
          id: '4',
          name: 'Mood Booster',
          description: 'Uplifting songs to boost your mood!',
          coverImageUrl: 'https://i.scdn.co/image/ab67706f00000002bd0e19e810bb4b55ab164a95',
          createdBy: 'Spotify',
          tracks: popularTracks.take(5).toList(),
          isPersonalized: false,
        ),
      ];

  List<Playlist> get recentlyPlayed => [
        Playlist(
          id: '5',
          name: 'This Is Harry Styles',
          description: 'All the best songs from Harry Styles',
          coverImageUrl: 'https://i.scdn.co/image/ab67706f000000025d8c77f4e5b112a4bbd02bcd',
          createdBy: 'Spotify',
          tracks: popularTracks.where((track) => track.artist == 'Harry Styles').toList(),
          isPersonalized: false,
        ),
        Playlist(
          id: '6',
          name: '2023 Wrapped',
          description: 'Your top songs of 2023',
          coverImageUrl: 'https://wrapped-images.spotifycdn.com/image/wrapped-2023/your-top-songs-2023.jpg',
          createdBy: 'Spotify',
          tracks: popularTracks.take(5).toList(),
          isPersonalized: true,
        ),
        Playlist(
          id: '7',
          name: 'Throwback Thursday',
          description: 'Classics that never get old',
          coverImageUrl: 'https://i.scdn.co/image/ab67706f000000027bcd851d15d9c69173cc22a7',
          createdBy: 'Spotify',
          tracks: popularTracks.skip(2).take(3).toList(),
          isPersonalized: false,
        ),
      ];

  // Mock artists
  List<Artist> get topArtists => [
        Artist(
          id: '1',
          name: 'Harry Styles',
          imageUrl: 'https://i.scdn.co/image/ab6761610000e5ebf7db7c8ede90a019c54590bb',
          monthlyListeners: 75429631,
          topTracks: popularTracks.where((track) => track.artist == 'Harry Styles').toList(),
          isFollowed: true,
        ),
        Artist(
          id: '2',
          name: 'The Weeknd',
          imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb214f3cf1cbe7139c1e26ffbb',
          monthlyListeners: 98762345,
          topTracks: popularTracks.where((track) => track.artist == 'The Weeknd').toList(),
          isFollowed: true,
        ),
        Artist(
          id: '3',
          name: 'Glass Animals',
          imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb70b5b4f28bb2360134451b75',
          monthlyListeners: 30457123,
          topTracks: popularTracks.where((track) => track.artist == 'Glass Animals').toList(),
          isFollowed: false,
        ),
        Artist(
          id: '4',
          name: 'Steve Lacy',
          imageUrl: 'https://i.scdn.co/image/ab6761610000e5eb7cb05fea3b3c2234620acf1d',
          monthlyListeners: 21893456,
          topTracks: popularTracks.where((track) => track.artist == 'Steve Lacy').toList(),
          isFollowed: false,
        ),
      ];

  // Mock genres
  List<Genre> get genres => [
        Genre(
          id: '1',
          name: 'Pop',
          backgroundColor: AppColors.genreColors[0],
        ),
        Genre(
          id: '2',
          name: 'Hip Hop',
          backgroundColor: AppColors.genreColors[1],
        ),
        Genre(
          id: '3',
          name: 'Rock',
          backgroundColor: AppColors.genreColors[2],
        ),
        Genre(
          id: '4',
          name: 'Dance / Electronic',
          backgroundColor: AppColors.genreColors[3],
        ),
        Genre(
          id: '5',
          name: 'R&B',
          backgroundColor: AppColors.genreColors[4],
        ),
        Genre(
          id: '6',
          name: 'Latin',
          backgroundColor: AppColors.genreColors[5],
        ),
        Genre(
          id: '7',
          name: 'Indie',
          backgroundColor: AppColors.genreColors[6],
        ),
        Genre(
          id: '8',
          name: 'Chill',
          backgroundColor: AppColors.genreColors[7],
        ),
        Genre(
          id: '9',
          name: 'Workout',
          backgroundColor: AppColors.genreColors[0],
        ),
        Genre(
          id: '10',
          name: 'Focus',
          backgroundColor: AppColors.genreColors[2],
        ),
      ];

  // Mock user's library
  List<Playlist> get userPlaylists => [
        Playlist(
          id: '8',
          name: 'Liked Songs',
          description: 'All your favorite songs',
          coverImageUrl: 'https://misc.scdn.co/liked-songs/liked-songs-640.png',
          createdBy: 'You',
          tracks: popularTracks.where((track) => track.isLiked).toList(),
          isPersonalized: true,
        ),
        ...recommendedPlaylists,
        ...recentlyPlayed,
      ];
} 